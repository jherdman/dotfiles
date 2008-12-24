set nocompatible " We don't want vi compatibility
syntax on
filetype plugin indent on " Automatically detect file types

syntax enable

runtime! macros/matchit.vim

augroup myfiletypes
  autocmd!
  
  " Ruby-type files will use
  autocmd FileType ruby,eruby,rake set ai sw=2 sts=2 et

  " YAML
  au BufNewFile,BufRead *.yaml, *.yml so ~/.vim/syntax/yaml.vim set ai sw=2 sts=2 et
augroup END

" Color scheme
colorscheme desert

" Make things pretty
set ruler
set showcmd

" Tab settings
" I follow the Ruby paradigm: soft tabs, 2 space width
set smarttab
set autoindent
set tabstop=2
set shiftwidth=2
set expandtab
set backspace=start,indent

" Catch common typos
nmap :W :w
nmap :Q :q

let g:proj_flags="imstvcg"

let mapleader=","

" Use ack instead of grep
set grepprg=ack
set grepformat=%f:%l%m

" Configurations that are system sensitive
if has("win32")
  map <C-T> <Esc>:tabnew<CR>
  set guifont=Consolas:h11:cANSI
else
  " GUI font stuff
  set guifont=Panic\ Sans:h14
  set backupdir=~/.backup
  set directory=~/.backup
endif

" Fuzzy Finder Settings
let g:fuzzy_ignore="*.log"
let g:fuzzy_matching_limit=70

map <LEADER>f :FuzzyFinderTextMate<CR>
map <LEADER>b :FuzzyFinderBuffer<CR>

nmap <silent> <LEADER>d <Plug>ToggleProject

" Comments out the line a la Ruby
map <LEADER># :s/^/#<CR>

map <M-]> :tabnext<CR>
map <M-[> :tabprevious<CR>
map <M-t> :tabnew<CR>
