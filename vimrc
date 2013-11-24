set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'kien/ctrlp.vim.git'
Bundle 'markabe/bufexplorer'
Bundle 'edsono/vim-matchit'
Bundle 'scrooloose/nerdtree'
Bundle 'godlygeek/tabular'
Bundle 'pangloss/vim-javascript'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-markdown'
Bundle 'mustache/vim-mode'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-liquid'
Bundle 'chriskempson/tomorrow-theme', {'rtp': 'vim/'}
Bundle 'tpope/vim-haml'
Bundle 'tpope/vim-unimpaired'
Bundle 'Lokaltog/vim-powerline'
Bundle 'tpope/vim-cucumber'
Bundle 'tpope/vim-surround'
Bundle 'groenewege/vim-less'
Bundle 'kchmck/vim-coffee-script'
Bundle 'slim-template/vim-slim'
Bundle 'nanotech/jellybeans.vim'
Bundle 'othree/html5.vim'
Bundle 'jnwhiteh/vim-golang'

" Required for Vundle
filetype plugin indent on

let mapleader=","

" Other basic settings

set nocompatible               " Use Vim settings, not Vi
set ruler                      " show cursor position all of the time
set showcmd                    " display incomplete commands
set spell
set nowrap
set smarttab
set autoindent
set tabstop=2
set shiftwidth=2
set expandtab
set backspace=eol,start,indent " backspacing over everything in insert mode
set hlsearch                   " highlight search terms
set incsearch                  " show search mates as you type
set ignorecase                 " ignore case when searching, but...
set smartcase                  " only when I'm using all lowercase search terms
set tags=tags                  " look in root of project, and work your way up
set number
set cursorline
set nobackup
set noswapfile
set clipboard=unnamed          " Vim behaves with clipboard now
set laststatus=2               " For Powerline

" Now you can do ";w" instead of ":w"
nnoremap ; :

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif

set t_Co=256
set background=dark
colorscheme jellybeans

" Disable ex mode
map Q <Nop>

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

" Clear search buffer
nmap <silent> <leader>/ :let @/=""<CR>

" Find and replace text under cursor
" http://vim.wikia.com/wiki/Search_and_replace_the_word_under_the_cursor
nnoremap <Leader>s :%s/\<<C-r><C-w>\>/

" NERDTree conveniences
map <F2> :NERDTreeToggle<CR>
map <leader>nb :NERDTreeFromBookmark 

" Tab completion
set wildmode=list:longest,list:full
set complete=.,w,t

" Exclude Javascript files in :Rtags via rails.vim due to warnings when parsing
let g:Tlist_Ctags_Cmd="ctags --exclude='*.js'"

" Index ctags from any project, including those outside Rails
map <Leader>ct :!ctags -R .<CR>

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

" Emblem, it's like Slim but for Ember
autocmd BufNewFile,BufRead *.emblem set syntax=slim

" CTRL-P settings
let g:ctrlp_extensions = ['tag']

let g:Powerline_symbols = 'fancy'

" Relative line numbers
function! NumberToggle()
  if(&relativenumber == 1)
    set number
  else
    set relativenumber
  endif
endfunc

nmap <silent> <Leader>n :call NumberToggle()<CR>

" Search up in Dash
nmap <silent> <leader>d <Plug>DashSearch

" Additional auto complete keywords
set iskeyword+=-

" Mustache/Handlebars abbreviations
let g:mustache_abbreviations = 1

if has("autocmd")
  au  BufNewFile,BufRead *.{mustache,handlebars,hbs,hogan,hulk,hjs}{,.erb} set filetype=html syntax=mustache | runtime! ftplugin/mustache.vim ftplugin/mustache*.vim ftplugin/mustache/*.vim
endif
