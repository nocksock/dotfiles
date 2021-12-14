" encoding: utf 8
"
" This is my messy .vimrc
"
" Author: Nils Riedemann
" Website: https://bleepbloop.studio/
" Repository: https://github.com/nocksock/dotfiles

" -- Basic options --------------------------------------------------------- {{{
let mapleader = "\<space>"

set autoindent                                           " Copy indent from current line when creating a new line                                            "
set autoread                                             " auto re-read file when it changed outside of vim, but not inside
set backspace=indent,eol,start                           " allow backspacing over everything in insert mode
set backup                                               " enable backups
set backupdir=/tmp
set backupdir=~/.vim/tmp/backup//                        " backups
set backupskip=/tmp/*,/private/tmp/*                     " Make Vim able to edit crontab files again.
set breakindent                                          " wrapped lines appear indendet
set clipboard=unnamed                                    " using * as default register - which makes system wide copy paste possible
set directory=/tmp                                       " Don't clutter my dirs up with swp and tmp files
set directory=~/.vim/tmp/swap//                          " swap files
set encoding=utf-8
set expandtab
set foldenable
set foldlevelstart=4
set foldmethod=marker
set foldnestmax=10
set formatoptions=qrn1
set formatoptions=qrn1
set gdefault                                             " add g flag by default for :substitutions
set hidden                                               " enable hidden buffers - so i can switch buffers even if current is changed.
set hlsearch
set ignorecase
set incsearch
set laststatus=2                                         " Always show status line.
set list                                                 " Show invisible characters                                                                         "
set listchars=tab:\|⋅,eol:¬,trail:-,extends:↩,precedes:↪
set mouse=a                                              " enable scrolling and selecting with mouse
set nocursorline                                         " Highlight the line of in which the cursor is present (or not)
set noswapfile                                           " It's 2012, Vim.
set nowrap
set nu rnu                                               " show *HYBRID* line numbers, relative line numbers + current line number
set ruler                                                " show the cursor position all the time
set shell=/bin/zsh                                       " set default shell for :shell
set shiftround                                           " When at 3 spaces and I hit >>, go to 4, not 5.
set shiftwidth=2
set showcmd                                              " display incomplete commands
set showmatch
set showmatch                                            " Highlight matching bracket
set showmode                                             " Show mode (insert, visual etc) on the last line
set smartcase
set softtabstop=2
set splitbelow                                           " When on, splitting a window will put the new window below the current one
set synmaxcol=500                                        " Until which column vim parses syntax
set t_8b=[48;2;%lu;%lu;%lum
set t_8f=[38;2;%lu;%lu;%lum
set t_Co=256                                             " term colors
set t_ut=
set tabstop=2
set termguicolors                                        " enable 24bit colors
set textwidth=80
set undodir=~/.vim/tmp/undo/                             " undo files
set undofile
set updatetime=1000                                      " how often to write swapfiles - some plugins, eg git-gutter use this for their update interval too
set wildignore+=*.DS_Store                               " OSX bullshit
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg           " binary images
set wildignore+=*.sw?                                    " Vim swap files
set wildignore+=.hg,.git,.svn                            " Version control
set wildmenu
set wildmode=longest,list,full
syntax on
" }}}

" -- Key Mappings ---------------------------------------------------------- {{{
" NOTE: this only refers to non-plugin related keymaps. Those for plugins are in
" the specific plugins config

" Window Management "{{{
" Easy window navigation
" map <C-h> <C-w>h
" map <C-j> <C-w>j
" map <C-k> <C-w>k
" map <C-l> <C-w>l

" Adding a bunch of ways to change tab to see which one sticks
nnoremap <C-t> <esc>:tabnew<cr>
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<cr>
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>

nmap <leader>Q :bufdo bdelete<cr>
map gf :edit <cfile><cr>

" Go to last active tab
au TabLeave * let g:lasttab = tabpagenr()
nnoremap <silent> <c-l> :exe "tabn ".g:lasttab<cr>
vnoremap <silent> <c-l> :exe "tabn ".g:lasttab<cr>
"}}}

" -- Movements ------------------------------------------------------------- {{{
" zoom to head level with a bit of context
nnoremap zh mzzt5<c-u>`z 

" Keep search matches in the middle of the window
nnoremap n nzzzv
nnoremap N Nzzzv

" C-R in visual mode to replace selected text
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

" press jk to Esc - much faster while typing
inoremap jk <ESC>

" highlight last inserted text
nnoremap gV `[v`]
" }}}

" -- quick edits (prefix: e) ----------------------------------------------- {{{
noremap <leader>ev :tabnew ~/dotfiles/.vimrc<CR>
noremap <leader>ez :tabnew ~/dotfiles/.zshrc<CR>
noremap <leader>et :tabnew ~/dotfiles/.tmux.conf<CR>
noremap <leader>ec :tabnew ~/dotfiles/.vim/coc-settings.json<CR>
noremap <leader>es :UltiSnipsEdit<CR>
""}}}

" -- miscallaneous --------------------------------------------------------- {{{

" Easy insertion of a trailing ; or , from insert mode
imap ;; <Esc>A;<Esc>
imap ,, <Esc>A,<Esc>

" Reselect visual selection after indenting
vnoremap < <gv
vnoremap > >gv

" gx to open links
nnoremap gx :execute '!open ' . shellescape(expand('<cWORD>'), 1)<cr>

" clear highlight
noremap <leader>ch :nohl<cr>

" clear popups, because sometimes a netrw gets stuck on screen.
noremap <leader>cp :call popup_clear()<cr>

" Clear popups and highlights
noremap <leader>cc :nohl<cr>:call popup_clear()<cr>

" Open current window in a new tab - useful for 'zooming' a window
nnoremap <c-w><space> :tab split<cr>
tnoremap <c-w><space> <c-w>:tab split<cr>

" toggle file-tree (netrw's explorer)
noremap <leader>tf :15Lex<cr> 

" open terminal at the bottom
noremap <leader>; :terminal ++rows=15<cr>

" keep muscle memory for saving often
noremap <c-s> :w<cr>
inoremap <c-s> <esc>:w<cr>i

" commenting
" NOTE: for some reason vim registers c-/ as c-_
" TODO: properly keep cursor position based on comment syntax # vs //
imap <c-_> <esc>mzgcc`zl
nmap <c-_> mzgcc`zl
vmap <c-_> mzgc`zgv

" search for word under cursor - without jumping to next or adding a jump in the
" jumplist. Useful in combination with cgn.
nnoremap * :keepjumps normal! mi*`i<CR>
" }}}
" }}}

" -- Plugins --------------------------------------------------------------- {{{
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" Putting plugin related configs into their own files so this .vimrc does not
" blow up and gets as messy as it did several times in the past. It does slow 
" down bootup by a handful of ms I guess. but it's a good trade atm.
source ~/.vim/plugins/auto-pairs.vim
source ~/.vim/plugins/ayu.vim
source ~/.vim/plugins/closetag.vim
source ~/.vim/plugins/coc.vim
source ~/.vim/plugins/commentary.vim
source ~/.vim/plugins/editorconfig.vim
source ~/.vim/plugins/emmet.vim
source ~/.vim/plugins/floaterm.vim
source ~/.vim/plugins/fugitive.vim
source ~/.vim/plugins/fzf.vim
source ~/.vim/plugins/gruvbox.vim
source ~/.vim/plugins/gundo.vim
source ~/.vim/plugins/javascript.vim
source ~/.vim/plugins/polyglot.vim
source ~/.vim/plugins/repeat.vim
source ~/.vim/plugins/surround.vim
source ~/.vim/plugins/table-mode.vim
source ~/.vim/plugins/tabular.vim
source ~/.vim/plugins/ultisnips.vim
source ~/.vim/plugins/vinegar.vim
source ~/.vim/plugins/zoom-toggle.vim

call plug#end()
"}}}

" -- Colorscheme ----------------------------------------------------------- {{{
colorscheme ayu

"Invisible character colors
highlight NonText guifg=#4a4a59
highlight SpecialKey guifg=#4a4a59

" " Theme configs
" let g:indentLine_char = '|'
" let g:indentLine_first_char = 'x'
" let g:indentLine_showFirstIndentLevel = 1
" let g:indentLine_setColors = 0

highlight ColorColumn ctermbg=red

call matchadd('ColorColumn', '\%81v', 100)

function! TransparentBG() 
  " making background transparent so iterm transparency is working
  highlight Normal guibg=NONE ctermbg=NONE 
endfunction
"}}}

" -- Config Meta ----------------------------------------------------------- {{{
" load local .vim if present 
let b:thisdir=expand("%:p:h")
let b:vim=b:thisdir."/.vim"
if (filereadable(b:vim))
    execute "source ".b:vim
endif

" edit and auto source vim file
autocmd! bufwritepost .vimrc source %

" Make Vim return to the same line when reopening a file.
augroup line_return
    au!
    au BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \     execute 'normal! g`"zvzz' |
      \ endif
augroup END

" When saving a buffer, create directories if they do not yet exist.
augroup Mkdir
  autocmd!
  autocmd BufWritePre * call mkdir(expand("<afile>:p:h"), "p")
augroup END
" }}}
