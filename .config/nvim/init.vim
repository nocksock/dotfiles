"
" Hi!
"
"   This is my messy but *also* large .vimrc
"

lua require('snock')

" some local modules
let &runtimepath.=','. expand("$HOME") . '/personal/ghash-vim' " an upcoming, hot colorscheme

let mapleader = "\<space>"
let maplocalleader = " \<c-@>"                           " use ctrl-space as local leader

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

nnoremap gx :execute '!open ' . shellescape(expand('<cWORD>'), 1)<cr>

nnoremap [t :tabprevious<cr>
nnoremap ]t :tabnext<cr>
nnoremap [T :tabfirst<cr>
nnoremap ]T :tablast<cr>
nnoremap [b :bprevious<cr>
nnoremap ]b :bnext<cr>
nnoremap [B :bfirst<cr>
nnoremap ]B :blast<cr>
nnoremap [d :LspDiagPrev<cr>
nnoremap ]d :LspDiagNext<cr>

nnoremap <leader><leader> <cmd>Telescope find_files theme=dropdown find_command=rg,--hidden,--files<cr>
nnoremap <leader>;     <cmd>terminal ++rows=15<cr>
nnoremap <leader>X     <cmd>ped ~/notes/x.md<cr>
nnoremap <leader>x     <cmd>ped .notes.md<cr>
nnoremap <leader>b     <cmd>Telescope buffers theme=dropdown<cr>
nnoremap <leader>/     <cmd>Telescope live_grep theme=dropdown find_command=rg,--hidden<cr>
nnoremap <leader>h     <cmd>Telescope help_tags<cr>
nnoremap <leader>r     <cmd>Telescope oldfiles<cr>
nnoremap <leader>R     <Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>
vnoremap <leader>R     <Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>
nnoremap <leader>T <cmd>Telescope<cr>

nnoremap <leader>dts mz:%s/ \+$//<cr>`z<cr> | " delete trailing spaces
nnoremap <leader>ci :call CocAction('runCommand', 'editor.action.organizeImport')<cr>

" vscode-likes (close to vscode bindings for presentations)
nnoremap <c-s> :w<cr>
nnoremap <leader>ki <Plug>:LspDiagLine
nnoremap <leader>.  <cmd>Telescope lsp_code_actions theme=cursor<cr>
nnoremap <F2> :LspRename<cr>

inoremap ;; <Esc>m`A;<esc>``i " Easy insertion of a trailing ; from insert mode
inoremap ,, <Esc>m`A,<esc>``i " Easy insertion of a trailing , from insert mode

cnoremap <expr> %%  getcmdtype() == ':' ? expand('%:h').'/' : '%%' " type %% in vim's prompt to insert %:h expanded

nnoremap n nzzzv " Keep search matches in the middle of the window
nnoremap N Nzzzv

nnoremap gV `[v`]   " visual select last inserted text

" reset view. mute search highlights, close preview, clear popups
nnoremap <silent> <c-l> :<c-u>:nohlsearch<cr>:pclose<cr><c-l>
nnoremap   <silent>   <F7>    :FloatermNew<CR>
tnoremap   <silent>   <F7>    <C-\><C-n>:FloatermNew<CR>
nnoremap   <silent>   <F8>    :FloatermPrev<CR>
tnoremap   <silent>   <F8>    <C-\><C-n>:FloatermPrev<CR>
nnoremap   <silent>   <F9>    :FloatermNext<CR>
tnoremap   <silent>   <F9>    <C-\><C-n>:FloatermNext<CR>
nnoremap   <silent>   <F12>   :FloatermToggle<CR>
tnoremap   <silent>   <F12>   <C-\><C-n>:FloatermToggle<CR>

" [j|t]sx? {{{

augroup ft_jtsx
  au!

  au BufNewFile,BufRead *.ts setlocal filetype=typescript
  au BufNewFile,BufRead *.js setlocal filetype=javascript.jsx
  au BufNewFile,BufRead *.tsx setlocal filetype=typescript.tsx

  autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart " force vim to parse the *entire* file from start.
  autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear

  au FileType javascript setlocal formatprg=prettier\ --parser\ typescript
  au FileType javascript nmap <localleader>s :e %:r:r.stories.js<cr>
  au FileType javascript nmap <localleader>t :e %:r:r.spec.js<cr>
  au FileType javascript nmap <localleader>m :e %:r:r.js<cr>

  au FileType javascript.jsx nmap <localleader>s :e %:r:r.stories.jsx<cr>
  au FileType javascript.jsx nmap <localleader>t :e %:r:r.spec.jsx<cr>
  au FileType javascript.jsx nmap <localleader>m :e %:r:r.jsx<cr>

  au FileType typescript setlocal formatprg=prettier\ --parser\ typescript\ --stdin-filepath\ %
  au FileType typescript setlocal formatexpr=   " reset Fixedgq from polyglot
  au FileType typescript nmap <localleader>t :e %:r:r.spec.ts<cr>
  au FileType typescript nmap <localleader>m :e %:r:r.ts<cr>

  au FileType typescript.tsx nmap <localleader>s :e %:r:r.stories.tsx<cr>
  au FileType typescript.tsx nmap <localleader>t :e %:r:r.spec.tsx<cr>
  au FileType typescript.tsx nmap <localleader>m :e %:r:r.tsx<cr>

  au FileType typescript.tsx :UltiSnipsAddFiletypes typescriptreact.typescript<cr>
augroup END

" }}}

augroup ft_misc
  au!
  au BufNewFile,BufRead *.zsh-theme setlocal filetype=zsh
  au BufNewFile,BufRead *.env.local setlocal filetype=sh
augroup END

" When saving a buffer, create directories if they do not yet exist.
augroup Mkdir
  autocmd!
  autocmd BufWritePre * call mkdir(expand("<afile>:p:h"), "p")
augroup END

" vim:fen fdm=marker fmr={{{,}}} fdl=0 ft=vim
