call plug#begin('~/.vim/plugged')

Plug 'chriskempson/base16-vim'
Plug 'itchyny/lightline.vim'
Plug 'markabe/bufexplorer'
Plug 'scrooloose/nerdtree'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'dense-analysis/ale'
Plug 'janko-m/vim-test'
Plug 'mileszs/ack.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'honza/vim-snippets'
Plug 'kassio/neoterm'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }

" Elixir Plugins
Plug 'elixir-editors/vim-elixir'

" Ruby Plugins
Plug 'tpope/vim-rails'

call plug#end()

filetype plugin indent on

let mapleader=","

" Other basic settings

set nocompatible               " Use Vim settings, not Vi
set ruler                      " show cursor position all of the time
set showcmd                    " display incomplete commands
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
set laststatus=2               " For Lightline
set fileencoding=utf-8

set inccommand=nosplit " Live substitution

" Spellchecking crap
autocmd FileType gitcommit setlocal spell

" Editor specific config (e.g. Oni vs. Terminal)
if exists('g:gui_oni')
else " terminal
  set noshowmode " Tell Vim to not show the mode, we have a plugin for that

  set termguicolors

  let base16colorspace=256
  colorscheme base16-materia

  set mouse=n
endif

syntax on

" Disable ex mode
map Q <Nop>

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

" Tab completion
set wildmode=list:longest,list:full
set complete=.,w,t

" Additional auto complete keywords
set iskeyword+=-

" Folds
set foldenable          " enable folding
set foldlevelstart=10   " open most folds by default
set foldnestmax=10      " 10 nested fold max

" space opens/closes folds
nnoremap <space> za

" Fugitive Mappings

" Auto-delete Fugitive buffers once I leave them
autocmd BufReadPost fugitive://* set bufhidden=delete

set wildmenu

" FZF Stuff
nnoremap <leader>f :FZF<CR>

" Test runner shit

let test#strategy = {
  \ 'nearest': 'neovim',
  \ 'suite': 'neoterm',
  \}

" Press this with terminal output to enter normal mode so you can scroll
" through terminal output
if has('nvim')
  tmap <C-o> <C-\><C-n>
end

nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>S :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>

" Ale

let g:ale_sign_column_always = 1
let g:ale_javascript_eslint_use_global = 1
let g:ale_fixers = { 'elixir': ['mix_format'] }
let g:ale_fix_on_save = 1
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" Ack

if executable('rg')
  let g:ackprg = 'rg --vimgrep'
endif

" COC

" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)
nnoremap <silent> <leader>co  :<C-u>CocList outline<CR>

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" use <tab> for trigger completion and navigate to the next complete item
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

let g:coc_global_extensions = [
  \ 'coc-ember',
  \ 'coc-elixir',
  \ 'coc-eslint',
  \ 'coc-marketplace',
  \ 'coc-prettier',
  \ 'coc-snippets',
  \ 'coc-tsserver',
  \ 'coc-json'
\ ]
