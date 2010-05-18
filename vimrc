set nocompatible " We don't want vi compatibility

"" see http://vimcasts.org/episodes/running-vim-within-irb
if has('autocmd')
  " Automatically detect file types
  filetype plugin indent on

  autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") |
        \   exe "normal! g `\"" |
        \ endif
endif

if &t_Co > 2 || has("gui_running")
  " Enable syntax highlighting
  syntax on
endif

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
function! <SID>StripTrailingWhitespaces()
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  %s/\s\+$//e
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction

nnoremap <silent> <F5> :call <SID>StripTrailingWhitespaces()<CR>

" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>

" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬

command! -nargs=* Wrap set wrap linebreak nolist

set showbreak=…

" Don't use Ex mode, use Q for formatting
map Q gq

" Softwrap mappings with command key
vmap <D-j> gj
vmap <D-k> gk
vmap <D-4> g$
vmap <D-6> g^
vmap <D-0> g^
nmap <D-j> gj
nmap <D-k> gk
nmap <D-4> g$
nmap <D-6> g^
nmap <D-0> g^

" Splits
"" Window
nmap <leader>sw<left>  :topleft  vnew<CR>
nmap <leader>sw<right> :botright vnew<CR>
nmap <leader>sw<up>    :topleft  new<CR>
nmap <leader>sw<down>  :botright new<CR>

"" Buffer
nmap <leader>s<left>  :leftabove  vnew<CR>
nmap <leader>s<right> :rightbelow vnew<CR>
nmap <leader>s<up>    :leftabove  new<CR>
nmap <leader>s<down>  :rightbelow new<CR>
