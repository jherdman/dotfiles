set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'kien/ctrlp.vim.git'
Bundle 'markabe/bufexplorer'
Bundle 'edsono/vim-matchit'
Bundle 'scrooloose/nerdtree'
Bundle 'ervandew/supertab'
Bundle 'godlygeek/tabular'
Bundle 'pangloss/vim-javascript'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-markdown'
Bundle 'kana/vim-smartinput'
Bundle 'scrooloose/nerdcommenter'
Bundle 'jherdman/snipmate.vim'
Bundle 'majutsushi/tagbar'
Bundle 'tpope/vim-cucumber'
Bundle 'nono/vim-handlebars'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-liquid'
Bundle 'sjl/badwolf'
Bundle 'Gundo'
Bundle 'groenewege/vim-less'

" Required for Vundle
filetype plugin indent on

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
set tags=tags                  " look in root of project, and work your way up
set backupdir=~/.tmp
set number
set cursorline

" Now you can do ";w" instead of ":w"
nnoremap ; :

syntax enable
set t_Co=256
set background=dark
colorscheme badwolf

" Disable ex mode
map Q <Nop>

" Configurations that are system sensitive
if has("win32")
  map <C-T> <Esc>:tabnew<CR>
  set guifont=Consolas:h12:cANSI
else
  set guifont=Menlo:h16
endif

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

" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬

command! -nargs=* Wrap set wrap linebreak nolist

set showbreak=…

" Don't use Ex mode, use Q for formatting
map Q gq

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

" Treat Thor files like Ruby
au BufRead,BufNewFile {Capfile,Thorfile,Guardfile,*.thor,*.rabl,*.ru} set ft=ruby

" Tagbar
let g:tagbar_ctags_bin = "/usr/local/bin/ctags"
map <F3> :TagbarToggle<CR>
