vim9script
filetype plugin indent on

set noerrorbells
set textwidth=100
set scrolloff=10
set nomodeline
set splitright
set splitbelow
set hidden
set wildmenu
set formatoptions+=j

set timeout
set timeoutlen=750

set autoread
set history=1000

set path=.,**

# swap / undo / backup
set noswapfile
set nobackup
set nowritebackup
set undofile
set undodir=$RTP/undo

# tabs / indent / spaces
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent
set expandtab
set smarttab
set cindent

# basic completion
set complete-=i
set complete+=k
set completeopt=menuone,noinsert

# Reduce noise
set shortmess+=c
set shortmess+=C

# UI
set number
set relativenumber
set cursorline
set ruler
set laststatus=2
set showmatch
set incsearch
set signcolumn=yes
set mouse=a

set display+=lastline
# set display+=truncate

#grep
set grepprg=rg\ --vimgrep

# Quickfix
set qftf=quickfix.QFFormat

# wrapping
set breakindent
set briopt=shift:4
set linebreak
set wrap

g:netrw_altfile = 1 
g:netrw_banner = 0
g:netrw_winsize = 33

