if exists("did_load_filetypes")
  finish
endif

augroup markdown
  au! BufRead,BufNewFile *.md   setfiletype mkd
augroup END

" Objective J
au BufNewFile,BufRead *.j setfiletype objj

" JSON
au! BufRead,BufNewFile *.json setfiletype json 
