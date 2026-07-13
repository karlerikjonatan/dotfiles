syntax on
filetype plugin indent on

set cursorline
set number
set ruler
set showcmd

set autoindent
set expandtab
set shiftwidth=2
set smarttab
set softtabstop=2
set tabstop=2

set nowrap

set hlsearch
set ignorecase
set incsearch
set smartcase

set backspace=indent,eol,start
set hidden
set wildmenu
set wildmode=longest:full,full

set encoding=utf-8

set list
set listchars=tab:»·,trail:·,extends:>,precedes:<

" Quality-of-life
set scrolloff=5              " keep context lines around the cursor
set sidescrolloff=8          " and columns (matters with nowrap)
set splitright               " vertical splits open to the right
set splitbelow               " horizontal splits open below
set mouse=a                  " enable mouse in all modes
set clipboard=unnamed        " yank/paste via macOS system clipboard (* register)
" Ctrl-L keeps its redraw meaning and also clears search highlight
nnoremap <silent> <C-l> :nohlsearch<CR><C-l>

set noswapfile

" Persistent undo (survives across sessions)
if !isdirectory($HOME . '/.vim/undo')
  call mkdir($HOME . '/.vim/undo', 'p', 0700)
endif
set undodir=$HOME/.vim/undo//
set undofile

" Reopen files at the last cursor position
augroup last_position
  autocmd!
  autocmd BufReadPost * if line("'\"") >= 1 && line("'\"") <= line("$") && &filetype !~# 'commit' | execute "normal! g`\"" | endif
augroup END
