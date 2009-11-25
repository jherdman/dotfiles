if exists("did_load_filetypes")
  finish
endif

augroup markdown
  au! BufRead,BufNewFile *.md   setfiletype mkd
augroup END
