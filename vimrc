set nocompatible " We don't want vi compatibility
syntax on
filetype plugin indent on " Automatically detect file types

syntax enable

runtime! macros/matchit.vim

augroup myfiletypes
  autocmd!
  
  " Ruby-type files will use
  autocmd FileType ruby,eruby set ai sw=2 sts=2 et

  " YAML
  au BufNewFile,BufRead *.yaml, *.yml so ~/.vim/syntax/yaml.vim set ai sw=2 sts=2 et
augroup END

" Color scheme
colorscheme wombat

" Make things pretty
set ruler
set showcmd

" Tab settings
" I follow the Ruby paradigm: soft tabs, 2 space width
set tabstop=2
set shiftwidth=2
set expandtab
set number

" Mappings
map <F4> :split

" Catch common typos
nmap :W :w
nmap :Q :q

" Insert pairs of common braces
imap { {}<ESC>i
imap ( ()<ESC>i
imap [ []<ESC>i
