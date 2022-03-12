"
" Hi!
"
"   This is my messy nvim configuration
"

let mapleader = "\<space>"
let maplocalleader = " \<c-@>"                           " use ctrl-space as local leader

filetype plugin on

set autoindent                                           " Copy indent from current line when creating a new line                            "
set autoread                                             " auto re-read file when it changed outside of vim, but not inside
set backspace=indent,eol,start                           " allow backspacing over everything in insert mode

set backup                                               " enable backups
set backupdir=/tmp
set backupdir=~/.config/nvim/tmp/backup/                 " backups
set backupskip=/tmp/*,/private/tmp/*                     " Make Vim able to edit crontab files again.

set breakindent                                          " wrapped lines appear indendet
set clipboard=unnamed
set completeopt=menu,menuone,noselect
set encoding=utf-8
set expandtab                                            " use spaces for indentation by default
set foldenable
set formatoptions=qrn1j                                  " format options when writing, joining lines or `gq` see  :he fo-table for meanings
set gdefault                                             " add g flag by default for :substitutions
set hidden                                               " enable hidden buffers - so i can switch buffers even if current is changed.
set signcolumn=yes
set history=10000                                        " keep way more commands in history
set hlsearch                                             " highlight search results
set incsearch                                            " enable incremental search that would make vim jump around while typing
set ignorecase                                           " ignore case by default - unless using uppercase/lowercase via smartcase
set list                                                 " Show invisible characters
set listchars=tab:\|⋅,eol:¬,trail:-,extends:↩,precedes:↪ " define characters for invisible characters
set mouse=a                                              " enable scrolling and selecting with mouse
set cursorline                                           " Highlight the line of in which the cursor is present (or not)
set nowrap                                               " don't wrap text around when the window is too small
set nu rnu                                               " show *HYBRID* line numbers, relative line numbers + current line number
set scrolloff=2                                          " always have 2 lines more visible when reaching top/end of a window when scrolling
set shell=/bin/zsh                                       " set default shell for :shell
set shiftround                                           " When at 3 spaces and I hit >>, go to 4, not 5.
set shiftwidth=2
set showcmd                                              " display incomplete commands
set showmatch                                            " Highlight matching bracket
set smartcase                                            " ignore 'ignorecase' when search contains uppercase characters
set softtabstop=2
set splitbelow                                           " When on, splitting a window will put the new window below the current one
set synmaxcol=500                                        " Until which column vim parses syntax
set tabstop=2
set termguicolors                                        " enable 24bit colors
set textwidth=80
set undodir=~/.config/nvim/tmp/undo/
set undofile

set t_Co=256                                             " term colors
set t_8b=[48;2;%lu;%lu;%lum                            " sometimes setting termguicolors for true color support  is not enough see
set t_8f=[38;2;%lu;%lu;%lum                            " :he t_8b
set t_ut=

set wildmenu
set wildignore+=*.DS_Store                               " ignore OSX bullshit
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg           " ignore binary images
set wildignore+=**/coverage/*
set wildignore+=**/node_modules/*
set wildignore+=**/android/*
set wildignore+=**/.git/*
set wildignore+=**/tmp/*
set wildmode=longest,list,full

" -- plugins and other settings
let g:UltiSnipsExpandTrigger="<c-l>"
let g:UltiSnipsJumpForwardTrigger="<c-l>"
let g:UltiSnipsJumpBackwardTrigger="<c-h>"
let g:netrw_altfile=1 " make CTRL-^ ignore netrw buffers
let g:db_ui_force_echo_notifications=1
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.js,*.jsx,*.tsx'
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx'
let g:closetag_filetypes = 'html,xhtml,phtml,jsx,tsx,javascript'
let g:closetag_xhtml_filetypes = 'xhtml,jsx,tsx'
let g:closetag_emptyTags_caseSensitive = 1
let g:closetag_regions = {
      \ 'typescript.tsx': 'jsxRegion,tsxRegion',
      \ 'javascript.jsx': 'jsxRegion',
      \ }
let g:closetag_shortcut = '>'
let g:closetag_close_shortcut = '<leader>>'

let &runtimepath.=','. expand("$HOME") . '/personal/ghash-vim' " an upcoming, hot colorscheme

augroup ft_jtsx
  au!
  autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart " force vim to parse the *entire* file from start.
  autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear
augroup END


" When saving a buffer, create directories if they do not yet exist.
augroup Mkdir
  autocmd!
  autocmd BufWritePre * call mkdir(expand("<afile>:p:h"), "p")
augroup END

" vim:fen fdm=marker fmr={{{,}}} fdl=0 ft=vim
