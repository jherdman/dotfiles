if !exists("jslint_mark_color")
	let jslint_mark_color = "error"
endif

if !exists('g:JavascriptLintConf')
	let g:JavascriptLintConf = 'jsl.default.conf'
endif

if !exists('g:InfoHighlight')
	let g:InfoHighlight = 'Error'
endif
if !exists('g:WarningHighlight')
	let g:WarningHighlight = 'Warning'
endif

autocmd BufWritePost,FileWritePost *.js call g:JsLint()

augroup jslint_show_error
	autocmd!
	autocmd CursorMoved * call ShowCurrentError()
augroup END

function! g:JsLint()
	let result = ''

	if !executable('jsl')
		echo "unable to excute command 'jsl', add it to enviroment variables."
		return
	else
		let command = 'jsl -process "' . expand('%:p') . '"'
		let conf = expand(g:JavascriptLintConf)
		if filereadable(conf)
			let command .= ' -conf "' . conf . '"'
		endif
		let result = System(command)
		if v:shell_error == 2 "|| v:shell_error == 4
			echo 'Error running command: ' . command
			return
		endif
	endif

	if result =~ ':'
		let results = split(result, '\n')
		let errors = []
		for error in results
			if error =~ '.\{-}(\d\+): .\{-}: .\{-}'
				let file = substitute(error, '\(.\{-}\)([0-9]\+):.*', '\1', '')
				let line = substitute(error, '.\{-}(\([0-9]\+\)):.*', '\1', '')
				let message = substitute(error, '.\{-}([0-9]\+):.\{-}: \(.*\)', '\1', '')
				let dict = {
				\ 'filename': Simplify(file),
				\ 'lnum': line,
				\ 'text': "[jsl] " . message,
				\ 'type': error =~ ': \(lint \)\?warning:' ? 'w' : 'e',
				\ }

				call add(errors, dict)
			endif
		endfor

		call SetPlaceHolder()
		call ClearLocaionList('jsl')
		call SetLocationList(errors, 'a')
		call RemovePlaceHolder()
	else
		call ClearLocaionList('jsl')
	endif

endfunction


function! SetPlaceHolder(...)
	if len(a:000) > 0 && a:000[0]
		let existing = GetExisting()
		if !len(existing)
			return
		endif
	endif

	call Define('placeholder', '_ ', g:jslint_mark_color)
	let existing = GetExisting('placeholder')
	if len(existing) == 0 && HasExisting()
		call Place('placeholder', 1)
		return 1
	endif
endfunction


" Define
function! Define(name, text, highlight)
	exec "sign define " . a:name . " text=" . a:text . " texthl=" . a:highlight
endfunction
	

" GetExisting
function! GetExisting(...)
	let bufnr = bufnr('%')

	redir => signs
	silent exec 'sign place buffer=' . bufnr
	redir END

	let existing = []
	for sign in split(signs, '\n')
		if sign =~ 'id='
			let id = substitute(sign, '.\{-}=.\{-}=\(.\{-}\)\s.*', '\1', '')
			exec 'let line = ' . substitute(sign, '.\{-}=\(.\{-}\)\s.*', '\1', '')
			let name = substitute(sign, '.\{-}=.\{-}=.\{-}=\(.\{-}\)\s*$', '\1', '')
			call add(existing, {'id': id, 'line': line, 'name': name})
		endif
	endfor

	if len(a:000) > 0
		call filter(existing, "v:val['name'] == a:000[0]")
	endif

	return existing
endfunction

function! HasExisting(...)
	let bufnr = bufnr('%')

	redir => results
		silent exec 'sign place buffer=' . bufnr
	redir END

	for sign in split(results, '\n')
		if sign =~ 'id='
			if len(a:000) == 0
				return 1
			endif
			let name = substitute(sign, '.\{-}=.\{-}=.\{-}=\(.\{-}\)\s*$', '\1', '')
			if name == a:000[0]
				return 1
			endif
		endif
	endfor
	return 0
endfunction

function! ClearLocaionList(...)
	if a:0 > 0
		let loclist = getloclist(0)
		if len(loclist) > 0
			let pattern = ''
			for ns in a:000
				if pattern != ''
					let pattern .= '\|'
				endif
				if ns == 'global'
					let pattern .= '\(\[\w\+\]\)\@!'
				else
					let pattern .= '\[' . ns . '\]'
				endif
			endfor
			let pattern = '^\(' . pattern . '\)'

			call filter(loclist, 'v:val.text !~ pattern')
			call setloclist(0, loclist, 'r')
		endif
	else
		call setloclist(0, [], 'r')
	endif
	call Update()
endfunction


function! System(cmd, ...)
	let saveshell = &shell
	let saveshellcmdflag = &shellcmdflag
	let saveshellpipe = &shellpipe
	let saveshellquote = &shellquote
	let saveshellredir = &shellredir
	let saveshellslash = &shellslash
	let saveshelltemp = &shelltemp
	let saveshellxquote = &shellxquote

	if has("win32") || has("win64")
		set shell=cmd.exe
		set shellcmdflag=/c
		set shellpipe=>%s\ 2>&1
		set shellquote=
		set shellredir=>%s\ 2>&1
		set noshellslash
		set shelltemp
		set shellxquote=
	else
		if executable('/bin/bash')
			set shell=/bin/bash
		else
			set shell=/bin/sh
		endif
		set shell=/bin/sh
		set shellcmdflag=-c
		set shellpipe=2>&1\|\ tee
		set shellquote=
		set shellredir=>%s\ 2>&1
		set noshellslash
		set shelltemp
		set shellxquote=
	endif

	if len(a:000) > 0 && a:000[0]
		let result = ''
		try
			exec a:cmd
		endtry
	else
		try
			let result = system(a:cmd)
		endtry
	endif

	let &shell = saveshell
	let &shellcmdflag = saveshellcmdflag
	let &shellquote = saveshellquote
	let &shellslash = saveshellslash
	let &shelltemp = saveshelltemp
	let &shellxquote = saveshellxquote

	" If a System call is executed at startup, it appears to interfere with
	" vim's setting of 'shellpipe' and 'shellredir' to their shell specific
	" values.  So, if we detect that the values we are restoring look like
	" uninitialized defaults, then attempt to mimic vim's documented
	" (:h 'shellpipe' :h 'shellredir') logic for setting the proper values based
	" on the shell.
	" Note: still doesn't handle more obscure shells
	if saveshellredir == '>'
		if index(s:bourne_shells, fnamemodify(&shell, ':t')) != -1
			set shellpipe=2>&1\|\ tee
			set shellredir=>%s\ 2>&1
		elseif index(s:c_shells, fnamemodify(&shell, ':t')) != -1
			set shellpipe=\|&\ tee
			set shellredir=>&
		else
			let &shellpipe = saveshellpipe
			let &shellredir = saveshellredir
		endif
	else
		let &shellpipe = saveshellpipe
		let &shellredir = saveshellredir
	endif
	return result
endfunction


function! Update()

	let save_lazy = &lazyredraw
	set lazyredraw

	call Define('error', '>>', "Error")
	let placeholder = SetPlaceHolder()

	" remove all existing signs
	let existing = GetExisting()
	for exists in existing
		if exists.name =~ '^\(error\|info\|warning\|qf_error\|qf_warning\)$'
			call Unplace(exists.id)
		endif
	endfor

	let qflist = getqflist()
	let list = filter(getloclist(0), 'bufnr("%") == v:val.bufnr')

  " if g:EclimSignLevel >= 4
	let info = filter(copy(qflist) + copy(list),
	\ 'bufnr("%") == v:val.bufnr && v:val.type == "i"')
	let locinfo = filter(copy(list),
	\ 'bufnr("%") == v:val.bufnr && v:val.type == ""')
	call extend(info, locinfo)
	call map(info, 'v:val.lnum')
	call Define("info", ">>", g:InfoHighlight)
	call PlaceAll("info", info)
  " endif

	" if g:EclimSignLevel >= 3
		let warnings = filter(copy(list), 'v:val.type == "w"')
		call map(warnings, 'v:val.lnum')
		call Define("warning", ">>", g:WarningHighlight)
		call PlaceAll("warning", warnings)
	" endif

	" if g:EclimSignLevel >= 2
		let errors = filter(copy(list), 'v:val.type == "e"')
		call map(errors, 'v:val.lnum')
		call PlaceAll("error", errors)
	" endif

	if placeholder
		call RemovePlaceHolder()
	endif

	let &lazyredraw = save_lazy
endfunction



function! Unplace(id)
  exec 'sign unplace ' . a:id . ' buffer=' . bufnr('%')
endfunction


function! Place(name, line)
  if a:line > 0
    let lastline = line('$')
    let line = a:line <= lastline ? a:line : lastline
    exec "sign place " . line . " line=" . line . " name=" . a:name .
      \ " buffer=" . bufnr('%')
  endif
endfunction " }}}


function! PlaceAll(name, list)
  let lastline = line('$')
  for line in a:list
    if line > 0
      let line = line <= lastline ? line : lastline
      exec "sign place " . line . " line=" . line . " name=" . a:name .
        \ " buffer=" . bufnr('%')
    endif
  endfor
endfunction




function! RemovePlaceHolder()
	let existing = GetExisting('placeholder')
	for exists in existing
		call Unplace(exists.id)
	endfor
endfunction


function! Simplify(file)
	let file = a:file

	" Don't run simplify on url files, it will screw them up.
	if file !~ '://'
	let file = simplify(file)
	endif

	" replace all '\' chars with '/' except those escaping spaces.
	let file = substitute(file, '\\\([^[:space:]]\)', '/\1', 'g')
	let cwd = substitute(getcwd(), '\', '/', 'g')
	if cwd !~ '/$'
	let cwd .= '/'
	endif

	if file =~ '^' . cwd
	let file = substitute(file, '^' . cwd, '', '')
	endif

	return file
endfunction " }}}



function! SetLocationList(list, ...)
  let loclist = a:list

  " filter the list if the current buffer defines a list of filters.
  " if exists('b:EclimLocationListFilter')
  "   let newlist = []
  "   for item in loclist
  "     let addit = 1
" 
  "     for filter in b:EclimLocationListFilter
  "       if item.text =~ filter
  "         let addit = 0
  "         break
  "       endif
  "     endfor
" 
  "     if addit
  "       call add(newlist, item)
  "     endif
  "   endfor
  "   let loclist = newlist
  " endif

  if a:0 == 0
    call setloclist(0, loclist)
  else
    call setloclist(0, loclist, a:1)
  endif
  " if len(loclist) > 0
    call DelayedCommand('call ShowCurrentError()')
  " endif
  call Update()
endfunction " }}}


let s:show_current_error_displaying = 0

function! ShowCurrentError()
  let message = GetLineError(line('.'))
  if message != ''
    " remove any new lines
    let message = substitute(message, '\n', ' ', 'g')

    if len(message) > (&columns - 1)
      let message = strpart(message, 0, &columns - 4) . '...'
    endif

    call WideMessage('echo', message)
    let s:show_current_error_displaying = 1
  else
    " clear the message if one of our error messages was displaying
    if s:show_current_error_displaying
      call WideMessage('echo', message)
      let s:show_current_error_displaying = 0
    endif
  endif
endfunction " }}}


function! GetLineError(line)
  let line = line('.')
  let col = col('.')

  let errornum = 0
  let errorcol = 0
  let index = 0

  let locerrors = getloclist(0)
  let qferrors = getqflist()
  let bufname = expand('%')
  let lastline = line('$')
  for error in qferrors + locerrors
    let index += 1
    if bufname(error.bufnr) == bufname &&
        \ (error.lnum == line || (error.lnum > lastline && line == lastline))
      if errornum == 0 || (col >= error.col && error.col != errorcol)
        let errornum = index
        let errorcol = error.col
      endif
    endif
  endfor

  if errornum > 0
    let src = 'qf'
    let cnt = len(qferrors)
    let errors = qferrors
    if errornum > cnt
      let errornum -= cnt
      let src = 'loc'
      let cnt = len(locerrors)
      let errors = locerrors
    endif

    let message = src . ' - (' . errornum . ' of ' . cnt . '): '
      \ . substitute(errors[errornum - 1].text, '^\s\+', '', '')
    return message
  endif
  return ''
endfunction " }}}


function! WideMessage(command, message)
  let saved_ruler = &ruler
  let saved_showcmd = &showcmd

  let message = substitute(a:message, '^\s\+', '', '')

  set noruler noshowcmd
  redraw
  exec a:command . ' "' . escape(message, '"\') . '"'

  let &ruler = saved_ruler
  let &showcmd = saved_showcmd
endfunction " }}}



function! DelayedCommand(command, ...)
  let uid = fnamemodify(tempname(), ':t:r')
  if &updatetime > 1
    exec 'let g:eclim_updatetime_save' . uid . ' = &updatetime'
  endif
  exec 'let g:eclim_delayed_command' . uid . ' = a:command'
  let &updatetime = len(a:000) ? a:000[0] : 1
  exec 'augroup delayed_command' . uid
    exec 'autocmd CursorHold * ' .
      \ '  if exists("g:eclim_updatetime_save' . uid . '") | ' .
      \ '    let &updatetime = g:eclim_updatetime_save' . uid . ' | ' .
      \ '    unlet g:eclim_updatetime_save' . uid . ' | ' .
      \ '  endif | ' .
      \ '  exec g:eclim_delayed_command' . uid . ' | ' .
      \ '  unlet g:eclim_delayed_command' . uid . ' | ' .
      \ '  autocmd! delayed_command' . uid
  exec 'augroup END'
endfunction " }}}
