" Use pathogen to easily modify the runtime path to include all plugins
" under the ~/.vim/bundle directory.
runtime! autoload/pathogen.vim
silent!  call pathogen#runtime_append_all_bundles()

let mapleader=","

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" Other basic settings

set nocompatible
set ruler
set showcmd
set spell
set nowrap
set smarttab
set autoindent
set tabstop=2
set shiftwidth=2
set expandtab
set backspace=eol,start,indent " backspacing over everything in insert mode"
set hlsearch                   " highlight search terms"
set incsearch                  " show search mates as you type"
set ignorecase                 " ignore case when searching, but...
set smartcase                  " only when I'm using all lowercase search terms"
set nobackup                   " backups... who needs em?
set tags=tags;./tmp/tags       " look in root of project, and work your way up

" Now you can do ";w" instead of ":w"
nnoremap ; :

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
if has("gui_running")
  colorscheme sonofobsidian

  set lines=48
  set columns=85

  " Hide the toolbar, but show tabs
  set guioptions=egmrt
else
  colorscheme desert
endif

" Catch common typos
nmap :W :w
nmap :Q :q
nmap :E :e
nmap :Tabe :tabe

" Disable ex mode
map Q <Nop>


" Use ack instead of grep
set grepprg=ack
set grepformat=%f:%l%m

" Configurations that are system sensitive
if has("win32")
  map <C-T> <Esc>:tabnew<CR>
  set guifont=Consolas:h12:cANSI
else
  " GUI font stuff
  set guifont=Menlo:h12
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

nnoremap <silent> <F6> :call <SID>StripTrailingWhitespaces()<CR>

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

" Markdown preview
imap <leader>p <ESC>:w!<CR>:!markdown % > %.mkd.html && open %.mkd.html<CR><CR>a
map  <leader>p <ESC>:w!<CR>:!markdown % > %.mkd.html && open %.mkd.html<CR><CR>a

" Open a method def via Ctags in a vertical split
map <C-\> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

" Toggle TagList
nnoremap <silent> <F8> :TlistToggle<CR>

" Clear search buffer
nmap <silent> <leader>/ :let @/=""<CR>

" Find and replace text under cursor
" http://vim.wikia.com/wiki/Search_and_replace_the_word_under_the_cursor
nnoremap <Leader>s :%s/\<<C-r><C-w>\>/
