"
" Tango Vim Color Scheme
" =======================
"
" For best results, set up your terminal with a Tango palette.
" Instructions for GNOME Terminal:
" http://uwstopia.nl/blog/2006/07/tango-terminal
"
" author:   Michele Campeotto <micampe@micampe.it>
"
set background=dark

hi clear
if exists("syntax_on")
    syntax reset
endif

let colors_name = "tango"

" Default Colors
hi Normal       guifg=#eeeeec guibg=#000000
hi Normal       ctermfg=white ctermbg=none
hi NonText      guifg=#555753 guibg=#000000 gui=none
hi NonText      ctermfg=grey ctermbg=none
hi Cursor       guibg=#d3d7cf
hi Cursor       ctermbg=grey
hi lCursor      guibg=#d3d7cf
hi lCursor      ctermbg=grey

" Search
hi Search       guifg=#000000 guibg=#c4a000
hi Search       ctermfg=black ctermbg=darkyellow cterm=none
hi IncSearch    guifg=#eeeeec gui=none guibg=#729fcf 
hi IncSearch    ctermfg=white gui=none ctermbg=blue cterm=none

" Window Elements
hi StatusLine   guifg=#eeeeec guibg=#4e9a06 gui=bold
hi StatusLine   ctermfg=white ctermbg=darkgreen cterm=bold
hi StatusLineNC guifg=#d3d7df guibg=#000000
hi StatusLineNC ctermfg=grey ctermbg=none
hi VertSplit    guifg=#eeeeec guibg=#eeeeec
hi VertSplit    ctermfg=white ctermbg=white
hi Folded       guifg=#eeeeec guibg=#75507b
hi Folded       ctermfg=white ctermbg=darkmagenta
hi FoldColumn   guifg=#75507b guibg=#000000
hi FoldColumn   ctermfg=darkmagenta ctermbg=none
hi Visual       guifg=#eeeeec  guibg=#729fcf 
hi Visual       ctermfg=white  ctermbg=blue cterm=none

" Specials
hi Todo         guifg=#8ae234 guibg=#4e9a06 gui=bold
hi Todo         ctermfg=green ctermbg=darkgreen
hi Title        guifg=#eeeeec gui=bold
hi Title        ctermfg=white

" Syntax
hi Constant     guifg=#c4a000
hi Constant     ctermfg=darkyellow
hi Number       guifg=#729fcf
hi Number       ctermfg=blue
hi Statement    guifg=#a40000 gui=bold
hi Statement    ctermfg=darkred
hi Identifier   guifg=#8ae234
hi Identifier   ctermfg=green
hi PreProc      guifg=#cc0000
hi PreProc      ctermfg=darkred
hi Comment      guifg=#06989a gui=italic
hi Comment      ctermfg=darkcyan cterm=none
hi Type         guifg=#d3d7cf gui=bold
hi Type         ctermfg=grey cterm=bold
hi Special      guifg=#75507b
hi Special      ctermfg=darkmagenta cterm=none
hi Error        guifg=#eeeeec guibg=#cc0000
hi Error        ctermfg=white ctermbg=darkred
hi ErrorMsg     guifg=#eeeeec guibg=#cc0000
hi ErrorMsg     ctermfg=white ctermbg=darkred

" Diff
hi DiffAdd      guifg=#eeeeec guibg=#4e9a06
hi DiffAdd      ctermfg=white ctermbg=darkgreen cterm=none
hi DiffChange   guifg=fg guibg=#555753 gui=none
hi DiffChange   ctermfg=none ctermbg=darkgrey cterm=none
hi DiffDelete   guifg=#d3d7cf guibg=#cc0000 gui=none
hi DiffDelete   ctermfg=grey ctermbg=darkred cterm=none
hi DiffText     guifg=fg guibg=#c4a000 gui=none
hi DiffText     ctermfg=none ctermbg=darkyellow cterm=none

" Popup menu
hi Pmenu        guifg=#eeeeec guibg=#75507b
hi Pmenu        ctermfg=white ctermbg=darkmagenta
hi PmenuSel     guifg=#000000 guibg=#eeeeec
hi PmenuSel     ctermfg=black ctermbg=white
hi PmenuSbar    guifg=#75507b guibg=#75507b
hi PmenuSbar    ctermfg=darkmagenta ctermbg=darkmagenta
hi PmenuThumb   guifg=#75507b guibg=#75507b
hi PmenuThumb   ctermfg=darkmagenta ctermbg=darkmagenta

" Tab pages
hi TabLine      guifg=#eeeeec guibg=#555753 
hi TabLine      ctermfg=white ctermbg=darkgrey 
hi TabLineSel   guifg=#eeeeec guibg=#000000 
hi TabLineSel   ctermfg=white ctermbg=none 
hi TabLineFill  guifg=#eeeeec guibg=#eeeeec 
hi TabLineFill  ctermfg=white ctermbg=white 

" Other
hi WildMenu     guifg=#eeeeec guibg=#000000 gui=bold
hi WildMenu     ctermfg=white ctermbg=none
hi LineNr       guifg=#fce94f guibg=bg
hi LineNr       ctermfg=yellow ctermbg=none
