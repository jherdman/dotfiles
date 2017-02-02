set nocompatible
filetype off

call plug#begin('~/.vim/plugged')

Plug 'chriskempson/base16-vim'
Plug 'markabe/bufexplorer'
Plug 'scrooloose/nerdtree'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Elixir Plugins
Plug 'elixir-lang/vim-elixir'
Plug 'slashmili/alchemist.vim'

" Ruby Plugins
Plug 'tpope/vim-rails'
Plug 'tpope/vim-cucumber'

" JavaScript Plugins
Plug 'walm/jshint.vim', { 'for': 'javascript' }
Plug 'othree/yajs.vim', { 'for': 'javascript' }

call plug#end()

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
set number
set cursorline
set nobackup
set noswapfile
set clipboard+=unnamedplus     " Always interact with the clipboard
set laststatus=2               " For Airline

let g:airline_powerline_fonts = 1

set t_Co=256
let base16colorspace=256
set background=dark
colorscheme base16-monokai

syntax on

" Disable ex mode
map Q <Nop>

" Disable keyword lookup
map K <Nop>

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
nnoremap <leader>nb :NERDTreeFromBookmark<Space>

" JSHint
nnoremap <leader>js :JSHint<CR>

" Tab completion
set wildmode=list:longest,list:full
set complete=.,w,t

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

" Additional auto complete keywords
set iskeyword+=-

" Mustache/Handlebars abbreviations
let g:mustache_abbreviations = 1

if has("autocmd")
  au  BufNewFile,BufRead *.{mustache,handlebars,hbs,hogan,hulk,hjs}{,.erb} set filetype=html syntax=mustache | runtime! ftplugin/mustache.vim ftplugin/mustache*.vim ftplugin/mustache/*.vim
endif

" Folds
set foldenable          " enable folding
set foldlevelstart=10   " open most folds by default
set foldnestmax=10      " 10 nested fold max

" space opens/closes folds
nnoremap <space> za

" Git conveniences
map <leader>g :Git<Space>

" Fugitive Mappings

" Auto-delete Fugitive buffers once I leave them
autocmd BufReadPost fugitive://* set bufhidden=delete

set wildmenu

" FZF Stuff
nnoremap <leader>f :FZF<CR>
