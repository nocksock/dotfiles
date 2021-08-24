" encoding: utf 8
"
" This is my messy .vimrc
"
" Author: Nils Riedemann
" Website: https://bleepbloop.studio/
" Repository: https://github.com/nocksock/dotfiles

" Plugins {{{
set nocompatible

if empty(glob("~/.vim/autoload/plug.vim"))
    execute '!curl -fLo ~/.vim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif

filetype off

call plug#begin('~/.vim/plugged')

Plug 'mileszs/ack.vim'                                                          " Fast, simple search via ack
Plug 'Raimondi/delimitMate'                                                     " provides insert mode auto-completion for quotes, parens, brackets, etc.
Plug 'scrooloose/syntastic'                                                     " syntax chacking for a bunch of languages
Plug 'kien/ctrlp.vim'                                                           " fuzzy file finder
Plug 'sjl/gundo.vim'                                                            " undo tree
Plug 'airblade/vim-gitgutter'                                                   " shows git diff markers in the sign column and stages/previews/undoes hunks and partial hunks.
Plug 'tpope/vim-commentary'                                                     " comment stuff out and back in via gc/gcc
Plug 'tpope/vim-fugitive'                                                       " a git wrapper in vim
Plug 'tpope/vim-repeat'                                                         " enable repeating supported plugin maps with `.`
Plug 'tpope/vim-surround'                                                       " quoting/parenthesizing made simple
Plug 'tpope/vim-vinegar'                                                        " improved netrw for file browsing
Plug 'jiangmiao/auto-pairs'                                                     " auto insert/delete brackets, parens, quotes etc
Plug 'godlygeek/tabular'                                                        " align text at character
Plug 'preservim/nerdtree'                                                       " The tree explorer

" themes
Plug 'tomasr/molokai'
Plug 'sainnhe/sonokai'
Plug 'morhetz/gruvbox'
Plug 'ayu-theme/ayu-vim'

" LSP
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete-lsp.vim'

" glorious web dev
Plug 'leafgarland/typescript-vim'
Plug 'mattn/emmet-vim', {'for': 'html'}
Plug 'othree/html5.vim', {'for' : 'html'}
Plug 'pangloss/vim-javascript', {'for' : ['javascript']}
Plug 'peitalin/vim-jsx-typescript'

Plug 'jparise/vim-graphql'                                                      " syntax highlighting in graphql`` template literals
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }            " syntaxi highlighting in styled()`` template literals

" Coc
Plug 'neoclide/coc.nvim', {'branch': 'release'} " code completion etc

call plug#end()

filetype plugin indent on
"}}}
" Basic Options {{{
let mapleader = "\<space>"
let maplocalleader = "\\"

set t_Co=256 " term colors
set encoding=utf-8
set number
set relativenumber
set shiftround " When at 3 spaces and I hit >>, go to 4, not 5.
set foldmethod=marker
set backspace=indent,eol,start " allow backspacing over everything in insert mode
set clipboard=unnamed
set ruler " show the cursor position all the time
set showcmd " display incomplete commands
set autoindent
set breakindent
set showmatch
set cursorline
set showmode
set splitbelow
set list
set backupdir=/tmp
set directory=/tmp " Don't clutter my dirs up with swp and tmp files
set autoread
set synmaxcol=160
set laststatus=2  " Always show status line.
set gdefault
set autoindent
set visualbell
set formatoptions=qrn1
set undofile
set shell=/bin/zsh
set foldenable
set foldlevelstart=4
set foldnestmax=10
let g:user_zen_leader_key = '<c-y>'
set t_ut=
set listchars=tab:\|⋅,eol:¬,trail:-,extends:↩,precedes:↪
set backupskip=/tmp/*,/private/tmp/* " Make Vim able to edit crontab files again.
" }}}
" Tabs, spaces, wrapping {{{
set tabstop=4
set shiftwidth=4
set softtabstop=4
set nowrap
set expandtab
set textwidth=80
set formatoptions=qrn1
" }}}
" Colors and Scheme "{{{

"Invisible character colors
highlight NonText guifg=#4a4a59
highlight SpecialKey guifg=#4a4a59

" Important for colors to work properly
if has('termguicolors')
    set termguicolors
endif

" The configuration options should be placed before `colorscheme sonokai`.
" let g:sonokai_style = 'andromeda'
colorscheme gruvbox
let g:gruvbox_contrast_dark="hard"

highlight ColorColumn ctermbg=red
call matchadd('ColorColumn', '\%81v', 100)

" Trailing whitespace {{{
" Only shown when not in insert mode so I don't go insane.

augroup trailing
    au!
    au InsertEnter * :set listchars-=trail:⌴
    au InsertLeave * :set listchars+=trail:⌴
augroup END

" }}}

" Highlight the status line
highlight StatusLine ctermfg=blue ctermbg=black

" VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

syntax on
"}}}
" Wildmenu "{{{
set wildmode=longest,list,full
set wildmenu
set wildignore+=.hg,.git,.svn                    " Version control
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
set wildignore+=*.sw?                            " Vim swap files
set wildignore+=*.DS_Store                       " OSX bullshit
"}}}
" Search Options"{{{
set ignorecase
set smartcase
set incsearch
set showmatch
set hlsearch
nnoremap / /\v
vnoremap / /\v
nnoremap <leader><space> :noh<cr>
"}}}
" Movement "{{{
nnoremap zh mzzt10<c-u>`z " zoom to head level

" Keep search matches in the middle of the window
nnoremap n nzzzv
nnoremap N Nzzzv

" Same when jumping around
nnoremap g; g;zz
nnoremap g, g,zz

" disable cursor keys to force myself to use hjkl
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>

" press jk to Esc - much faster while typing
inoremap jk <ESC>

" highlight last inserted text
nnoremap gV `[v`]
" }}}
" Window Management "{{{
" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
map <leader>w <C-w>v<C-w>l
map <C-t> <esc>:tabnew<CR>
map <c-x> <C-w><c-x>
"}}}
" Modeline Magic {{{
" Taken from: http://vim.wikia.com/wiki/Modeline_magic
" Append modeline after last line in buffer.
" Use substitute() instead of printf() to handle '%%s' modeline in LaTeX
" files.
function! AppendModeline()
  let l:modeline = printf(" vim: set ts=%d sw=%d tw=%d cc=80 ft=%s:",
        \ &tabstop, &shiftwidth, &textwidth, &ft)
  let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
  call append(line("$"), l:modeline)
endfunction

nnoremap <silent> <Leader>ml :call AppendModeline()<CR>
"}}}
" Backups {{{
set undodir=~/.vim/tmp/undo//     " undo files
set backupdir=~/.vim/tmp/backup// " backups
set directory=~/.vim/tmp/swap//   " swap files
set backup                        " enable backups
set noswapfile                    " It's 2012, Vim.

" Make those folders automatically if they don't already exist.
if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&backupdir))
    call mkdir(expand(&backupdir), "p")
endif
if !isdirectory(expand(&directory))
    call mkdir(expand(&directory), "p")
endif
" }}}
" load local .vim if present {{{
let b:thisdir=expand("%:p:h")
let b:vim=b:thisdir."/.vim"
if (filereadable(b:vim))
    execute "source ".b:vim
endif
"}}}
" FileType Specifics {{{
" .HTML"{{{
" fold current tag
augroup ft_html
	au!
	au FileType html setlocal foldmethod=syntax
	au Filetype html setlocal noexpandtab
  au FileType html setlocal omnifunc=htmlcomplete#CompleteTags
augroup END
" }}}
" .CSS "{{{
augroup ft_css
  au!
  au BufNewFile,BufRead *.less setlocal filetype=less
  au BufNewFile,BufREad *.scss setlocal filetype=sass

  au Filetype sass,less,css setlocal foldmethod=marker
  au Filetype sass,less,css setlocal foldmarker={,}
  au Filetype sass,less,css setlocal omnifunc=csscomplete#CompleteCSS
  au Filetype sass,less,css setlocal iskeyword+=-

  au BufNewFile,BufRead *.scss,*.less,*.css nnoremap <buffer> <localleader>S ?{<CR>jV/\v^\s*\}?$<CR>k:sort<CR>:noh<CR>
augroup END
" }}}
" .JS JavaScript {{{

let g:coc_global_extensions = [
  \ 'coc-tsserver'
  \ ]

if isdirectory('./node_modules') && isdirectory('./node_modules/prettier')
  let g:coc_global_extensions += ['coc-prettier']
endif

if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
  let g:coc_global_extensions += ['coc-eslint']
endif

nnoremap <silent> K :call CocAction('doHover')<CR>

if executable('typescript-language-server')
	au User lsp_setup call lsp#register_server({
				\ 'name': 'javascript support using typescript-language-server',
				\ 'cmd': { server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
				\ 'root_uri': { server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_directory(lsp#utils#get_buffer_path(), '.git/..'))},
				\ 'whitelist': ['javascript', 'javascript.jsx', 'javascriptreact']
				\ })
endif

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    inoremap <buffer> <expr><c-f> lsp#scroll(+4)
    inoremap <buffer> <expr><c-d> lsp#scroll(-4)

    let g:lsp_format_sync_timeout = 1000
    autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')

    " refer to doc to add more commands
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

augroup ft_javascript
	au!
	au BufNewFile,BufRead .jshintrc setlocal filetype=javascript
	au BufNewFile,BufRead Gruntfile setlocal filetype=javascript

	au FileType javascript setlocal foldmethod=marker
	au FileType javascript setlocal foldmarker={,}

  au FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS

	" only show invisble characters in normal mode. just trying to see if i like
	" that
	au FileType javascript :au InsertLeave *.js setlocal nolist
	au FileType javascript :au InsertEnter *.js setlocal list
augroup END
" }}}
" .PDE Processing {{{
augroup ft_pde
	au BufNewFile,BufRead *.pde setlocal filetype=java
	au Filetype java nnoremap <Leader>bb :!processing-java --run --sketch=$(pwd) --output=$(pwd)/tmp --force<CR>
	au Filetype java nnoremap <Leader>bf :!processing-java --present --sketch=$(pwd) --output=$(pwd)/tmp --force<CR>
augroup END
" }}}
" }}}
" CTRLP {{{
nnoremap <c-b> :CtrlPBuffer<cr>
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.?(git|hg|svn|bower_components|node_modules)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }
"}}}
" NERD Tree{{{
nnoremap <c-b> :NERDTreeToggle<CR>
nnoremap <c-f> :NERDTreeFind<CR>
"}}}
" Miscellaneous {{{

" commenting
imap <C-_> <esc>mzgcc`zi
map <c-_>/ mzgcc`z

" Make sure Vim returns to the same line when you reopen a file.
augroup line_return
    au!
    au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \     execute 'normal! g`"zvzz' |
        \ endif
augroup END

if file_readable(".vim")
	source .vim
	echom ".vim sourced"
endif
"}}}
