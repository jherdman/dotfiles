set nocompatible " We don't want vi compatibility
syntax on
filetype plugin indent on " Automatically detect file types

syntax enable

runtime! macros/matchit.vim

" Color scheme
colorscheme desert

" Make things pretty
set ruler
set showcmd
set spell
set nowrap

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
nmap :E :e
nmap :Tabe :tabe

" Disable ex mode
map Q <Nop>

let mapleader=","

" Use ack instead of grep
set grepprg=ack
set grepformat=%f:%l%m

" Configurations that are system sensitive
if has("win32")
  map <C-T> <Esc>:tabnew<CR>
  set guifont=Consolas:h12:cANSI
else
  " GUI font stuff
  set guifont=Inconsolata:h14
  set backupdir=~/.backup
  set directory=~/.backup
endif

map <M-]> :tabnext<CR>
map <M-[> :tabprevious<CR>
map <M-t> :tabnew<CR>

" Fold Options
au BufWinLeave ?* mkview " auto-save folds
au BufWinEnter ?* silent loadview " automatically load folds silently

" Always use UNIX format
set fileformats=unix,dos

" Gist plugin copy command
let g:gist_clip_command = 'pbcopy'

" Remove extra whitespace
:nnoremap <silent> <F6> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>
