if exists("did_load_filetypes")
  finish
endif

" JSON
au! BufRead,BufNewFile *.json setfiletype json 
