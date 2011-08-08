set nocompatible
filetype off

set rtp+=~/.vim/vundle.git

call vundle#rc()

Bundle 'devbox-dark-256'
Bundle 'wincent/Command-T'
Bundle 'markabe/bufexplorer'
Bundle 'sjl/gundo.vim'
Bundle 'edsono/vim-matchit'
Bundle 'scrooloose/nerdtree'
Bundle 'ervandew/supertab'
Bundle 'godlygeek/tabular'
Bundle 'altercation/vim-colors-solarized'
Bundle 'skammer/vim-css-color'
Bundle 'tpope/vim-cucumber'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-haml'
Bundle 'pangloss/vim-javascript'
Bundle 'hallison/vim-markdown'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-surround'
Bundle 'hallettj/jslint.vim'
Bundle 'scrooloose/nerdcommenter'
Bundle 'jherdman/snipmate.vim'
Bundle 'kchmck/vim-coffee-script'
Bundle 'majutsushi/tagbar'
Bundle 'tpope/vim-fugitive'

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
set tags=tags;./tmp/tags       " look in root of project, and work your way up
set backupdir=~/.tmp
set number

" Now you can do ";w" instead of ":w"
nnoremap ; :

"" see http://vimcasts.org/episodes/running-vim-within-irb
if has('autocmd')
  " Automatically detect file types
  filetype plugin indent on

  autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") |
        \   exe "normal! g `\"" | \ endif
endif

if &t_Co > 2 || has("gui_running")
  syntax on
endif

" Color scheme
if has("gui_running")
  set background=dark
  colorscheme solarized

  set lines=48
  set columns=85

  " Hide the toolbar, but show tabs
  set guioptions=egmrt
else
  colorscheme devbox-dark-256
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
  set guifont=Menlo:h16
endif

map <M-]> :tabnext<CR>
map <M-[> :tabprevious<CR>
map <M-t> :tabnew<CR>

" Always use UNIX format
set fileformats=unix,dos

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

" Open a method def via Ctags in a vertical split
map <C-\> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

" Clear search buffer
nmap <silent> <leader>/ :let @/=""<CR>

" Find and replace text under cursor
" http://vim.wikia.com/wiki/Search_and_replace_the_word_under_the_cursor
nnoremap <Leader>s :%s/\<<C-r><C-w>\>/

" Toggle comments
map <D-/> <plug>NERDCommenterToggle

" Tabularize settings

nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a: :Tabularize /:\zs<CR>
vmap <Leader>a: :Tabularize /:\zs<CR>

" NERDTree convenience
map <F2> :NERDTreeToggle<CR>

function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction

if has('statusline')
  set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P
  set laststatus=2
end

" Treat Thor files like Ruby
au BufRead,BufNewFile {Capfile,Thorfile,Guardfile,*.thor,*.rabl} set ft=ruby

" CoffeeScript bundle customizations
let coffee_folding = 1
autocmd BufWritePost *.coffee silent CoffeeMake! -b | cwindow

" Haskell stuff
let g:haddock_browser = "open -a 'Google Chrome'"
let g:ghc = "/usr/bin/ghci"
let g:haddock_docdir = "/usr/share/doc/ghc/html"

" Tagbar
let g:tagbar_ctags_bin = "/usr/local/bin/ctags"
map <F3> :TagbarToggle<CR>
