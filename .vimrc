" encoding: utf 8
"
" This is my messy .vimrc
"
" Author: Nils Riedemann
" Website: https://bleepbloop.studio/
" Repository: https://github.com/nocksock/dotfiles

" -- Plugins --------------------------------------------------------------- {{{
" -- vim-plug setup -------------------------------------------------------- {{{
set nocompatible
if empty(glob("~/.vim/autoload/plug.vim"))
    execute '!curl -fLo ~/.vim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif
filetype off
call plug#begin('~/.vim/plugged')
""}}}

Plug 'mileszs/ack.vim'                                                          " Fast, simple search via ack
" Plug 'Raimondi/delimitMate'                                                     " provides insert mode auto-completion for quotes, parens, brackets, etc.
Plug 'scrooloose/syntastic'                                                     " syntax chacking for a bunch of languages
Plug 'tpope/vim-commentary'                                                     " comment stuff out and back in via gc/gcc
Plug 'tpope/vim-repeat'                                                         " enable repeating supported plugin maps with `.`
Plug 'tpope/vim-surround'                                                       " quoting/parenthesizing made simple
Plug 'jiangmiao/auto-pairs'                                                     " auto insert/delete brackets, parens, quotes etc
Plug 'godlygeek/tabular'                                                        " align text at character
Plug 'editorconfig/editorconfig-vim'                                            " Parse .editorconfig
Plug 'pelodelfuego/vim-swoop'                                                   " Search and edit results in multiple files at once (!)
Plug 'SirVer/ultisnips'                                                         " Snippets
Plug 'chrisbra/nrrwrgn'                                                         " edit a region in a separate buffer (emacs' narrow-region)

" File History, Versioning
Plug 'sjl/gundo.vim'                                                            " undo tree - who needs version control, when you have vim?
Plug 'airblade/vim-gitgutter'                                                   " shows git diff markers in the sign column and stages/previews/undoes hunks and partial hunks.
Plug 'tpope/vim-fugitive'                                                       " a git wrapper in vim

" File Navigation
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }                             " fzf <3 rip ctrlp
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-vinegar'                                                        " improved netrw for file browsing

" Themes
Plug 'ayu-theme/ayu-vim'                                                        " has a nice dark and light theme

" LSP and autocomplete
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'} " code completion etc

" Making web dev bareable
Plug 'leafgarland/typescript-vim'
Plug 'pangloss/vim-javascript'
Plug 'peitalin/vim-jsx-typescript'
Plug 'mattn/emmet-vim'                                                          " h1{emmet is awesome}+ul>li{It is!}*3
Plug 'othree/html5.vim'

Plug 'MaxMEllon/vim-jsx-pretty'                                                 " Better syntax highlighting for jsx
Plug 'HerringtonDarkholme/yats.vim'                                             " Yet Another TypeScript Syntax
Plug 'jparise/vim-graphql'                                                      " syntax hilighting in graphql`` template literals
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }            " syntax hilighting in styled`` template literals
Plug 'iamcco/coc-tailwindcss',
  \ {'do': 'yarn install --frozen-lockfile && yarn run build'}

Plug 'zoubin/vim-gotofile', { 'for': 'javascript' }                             " cursor on an import expression, gf will bring me to the main file of a node_module

call plug#end()

filetype plugin indent on
"}}}

" Basic Options {{{
let mapleader = "\<space>"
let maplocalleader = "\\"

set t_Co=256                                             " term colors
set encoding=utf-8
set relativenumber                                       " show relative line numbers numbers
set shiftround                                           " When at 3 spaces and I hit >>, go to 4, not 5.
set foldmethod=marker
set backspace=indent,eol,start                           " allow backspacing over everything in insert mode
set clipboard=unnamed
set ruler                                                " show the cursor position all the time
set showcmd                                              " display incomplete commands
set autoindent
set breakindent
set showmatch
set cursorline                                           " Highlight the line of in which the cursor is present
set showmode
set splitbelow
set list                                                 " Show invisible characters                            "
set mouse=a                                              " enable scrolling and selecting with mouse
set backupdir=/tmp
set directory=/tmp                                       " Don't clutter my dirs up with swp and tmp files
set autoread
set synmaxcol=500                                        " Until which column vim parses syntax
set laststatus=2                                         " Always show status line.
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
set backupskip=/tmp/*,/private/tmp/*                     " Make Vim able to edit crontab files again.

" }}}

" Tabs, spaces, wrapping {{{
set tabstop=2
set shiftwidth=2
set softtabstop=2
set nowrap
set expandtab
set textwidth=80
set formatoptions=qrn1
" }}}

" Colors and Scheme "{{{

"Invisible character colors
highlight NonText guifg=#4a4a59
highlight SpecialKey guifg=#4a4a59

" Theme configs
set termguicolors

let g:indentLine_char = '|'
let g:indentLine_first_char = 'x'
let g:indentLine_showFirstIndentLevel = 1
let g:indentLine_setColors = 0

let g:ayucolor="mirage"
colorscheme ayu
highlight ColorColumn ctermbg=red
call matchadd('ColorColumn', '\%81v', 100)

" Only shown when not in insert mode so I don't go insane.
augroup trailing
    au!
    au InsertEnter * :set listchars-=trail:⌴
    au InsertLeave * :set listchars+=trail:⌴
augroup END

" Autoclose HTML Tags{{{
" filenames like *.xml, *.html, *.xhtml, ...
" These are the file extensions where this plugin is enabled.
"
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.php'

" filenames like *.xml, *.xhtml, ...
" This will make the list of non-closing tags self-closing in the specified files.
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx,*.php'

" filetypes like xml, html, xhtml, ...
" These are the file types where this plugin is enabled.
let g:closetag_filetypes = 'html,xhtml,phtml,php'

" filetypes like xml, xhtml, ...
" This will make the list of non-closing tags self-closing in the specified files.
let g:closetag_xhtml_filetypes = 'xhtml,jsx,php'

" integer value [0|1]
" This will make the list of non-closing tags case-sensitive (e.g. `<Link>` will be closed while `<link>` won't.)
let g:closetag_emptyTags_caseSensitive = 1

" dict
" Disables auto-close if not in a "valid" region (based on filetype)
"
" let g:closetag_regions = {
"     \ 'typescript.tsx': 'jsxRegion,tsxRegion',
"     \ 'javascript.jsx': 'jsxRegion',
"     \ 'typescriptreact': 'jsxRegion,tsxRegion',
"     \ 'javascriptreact': 'jsxRegion',
"     \ }
"
" Shortcut for closing tags, default is '>'
let g:closetag_shortcut = '>'

" Add > at current position without closing the current tag, default is ''
let g:closetag_close_shortcut = '<leader>>'
" }}}
syntax on
"}}}

" Wildmenu ----------------------------------------------------------------- {{{
set wildmode=longest,list,full
set wildmenu
set wildignore+=.hg,.git,.svn                    " Version control
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
set wildignore+=*.sw?                            " Vim swap files
set wildignore+=*.DS_Store                       " OSX bullshit
"}}}

" -- netrw config ---------------------------------------------------------- {{{

" gx to open links
nnoremap gx :execute '!open ' . shellescape(expand('<cWORD>'), 1)<cr>

" }}}

" Search Options"{{{
set ignorecase
set smartcase
set incsearch
set showmatch
set hlsearch
" nnoremap / /\v
" vnoremap / /\v
"}}}

" Movement "{{{
nnoremap zh mzzt10<c-u>`z " zoom to head level

" Keep search matches in the middle of the window
nnoremap n nzzzv
nnoremap N Nzzzv

" press jk to Esc - much faster while typing
inoremap jk <ESC>

" highlight last inserted text
nnoremap gV `[v`]
" }}}

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
" Go to last active tab

au TabLeave * let g:lasttab = tabpagenr()
nnoremap <silent> <c-l> :exe "tabn ".g:lasttab<cr>
vnoremap <silent> <c-l> :exe "tabn ".g:lasttab<cr>
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

" -- Snippets (UltiSnips) -------------------------------------------------- {{{
" Open the UltiSnipsEdit in a new tab
let g:UltiSnipsEditSplit='tabdo'
""}}}

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

" .vimrc {{{
augroup ft_vim
    au!
    au FileType vim nnoremap <c-e> :exe getline('.')<cr>
augroup END

" edit and auto source vim file
autocmd! bufwritepost .vimrc source %

" Load a .vim file, if present - useful for project specific settings.
if file_readable(".vim")
    source .vim
    echom ".vim sourced"
endif
" }}}

" .JS JavaScript {{{
autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear

let g:coc_global_extensions = [
            \ 'coc-tsserver'
            \ ]

" Map <tab> for trigger completion, completion confirm, snippet expand and jump
" like VSCode. 

	" inoremap <silent><expr> <TAB>
	"   \ pumvisible() ? coc#_select_confirm() :
	"   \ coc#expandableOrJumpable() ?
	"   \ "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
	"   \ <SID>check_back_space() ? "\<TAB>" :
	"   \ coc#refresh()

	function! s:check_back_space() abort
	  let col = col('.') - 1
	  return !col || getline('.')[col - 1]  =~# '\s'
	endfunction

	let g:coc_snippet_next = '<c-j>'

" if isdirectory('./node_modules') && isdirectory('./node_modules/prettier')
"     let g:coc_global_extensions += ['coc-prettier']
" endif

if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
    let g:coc_global_extensions += ['coc-eslint']
endif

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
    au FileType javascript setlocal foldmethod=marker
    au FileType javascript setlocal foldmarker={,}
    au FileType javascript :au InsertLeave *.js setlocal nolist
    au FileType javascript :au InsertEnter *.js setlocal list
augroup END
" }}}

" .RS Rust {{{
if executable('rls')
   au User lsp_setup call lsp#register_server({
    \ 'name': 'rls',
    \ 'cmd': {server_info->['rustup', 'run', 'stable', 'rls']},
    \ 'workspace_config': {'rust': {'clippy_preference': 'on'}},
    \ 'whitelist': ['rust'],
    \ })
endif
"}}}

" .PDE Processing {{{
augroup ft_pde
    au BufNewFile,BufRead *.pde setlocal filetype=java
    au Filetype java nnoremap <Leader>bb :!processing-java --run --sketch=$(pwd) --output=$(pwd)/tmp --force<CR>
    au Filetype java nnoremap <Leader>bf :!processing-java --present --sketch=$(pwd) --output=$(pwd)/tmp --force<CR>
augroup END
" }}}

" Miscellaneous {{{
command! FF call fzf#run(fzf#wrap({'source' : 'find .'}))
" -- file related (prefix: f) -------------------------------------------- {{{
" TODO: detect if .git is present otherwise make <leader>ff use :Files
"
if isdirectory('./.git') 
nnoremap <leader><space> :GFiles<cr>
else 
nnoremap <leader><space> :Files<cr>
endif
noremap <leader>fr :History<cr>
noremap <leader>fb :Buffers<cr>
noremap <leader>fl :Lines<cr>
noremap <leader>ft :15Lex<cr>
nnoremap <leader>fp :CocCommand prettier.formatFile<cr>
nnoremap <leader>fs :w<cr>
""}}}
" -- searching (prefix: s) ------------------------------------------------- {{{
noremap <leader>ss :Ag<cr>
""}}}
" -- quick edits (prefix: e) ----------------------------------------------- {{{
noremap <leader>ev :tabnew ~/dotfiles/.vimrc<CR>
noremap <leader>es :UltiSnipsEdit<CR>
""}}}

" 
noremap <leader>hh :Helptags<cr>

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

" quickfix bindings
noremap <leader>] :cnext<cr>
nnoremap <leader>[ :cprev<cr>

" Git bindings
noremap <leader>gg :Git<cr>

" Coc Bindings
noremap <leader>coa :CocAction<cr>
noremap <leader>coi :call CocAction('runCommand', 'editor.action.organizeImport')

" Theme light/dark switch
let ayucolor="dark"

function! ToggleLight(mode)
  if a:mode == "light" 
    set background=dark
    return "dark"
  else 
    set background=light
    return "light"
  endif
endfunction

noremap <leader>tt :let ayucolor=ToggleLight(ayucolor)<cr>:colors ayu<cr>

" search for word under cursor - without jumping to next or adding a jump in the
" jumplist. Useful in combination with cgn.
nnoremap * :keepjumps normal! mi*`i<CR>

" clear highlight
noremap <leader>ch :nohl<cr>

" clear popups,  because sometimes a netrw gets stuck on screen.
noremap <leader>cp :call popup_clear()<cr>

" Clear popups and highlights
noremap <leader>cc :nohl<cr>:call popup_clear()<cr>

" Open current window in a new tab - useful for 'zooming' a window, eg :terminal,
" without destroying the layout
nnoremap <c-w><space> :tab split<cr>
tnoremap <c-w><space> <c-w>:tab split<cr>

" Zoom / Restore window {{{
" credit: https://stackoverflow.com/questions/13194428/is-better-way-to-zoom-windows-in-vim-than-zoomwin/26551079#26551079
function! s:ZoomToggle() abort
    if exists('t:zoomed') && t:zoomed
        execute t:zoom_winrestcmd
        let t:zoomed = 0
    else
        let t:zoom_winrestcmd = winrestcmd()
        resize
        vertical resize
        let t:zoomed = 1
    endif
endfunction
command! ZoomToggle call s:ZoomToggle()

nnoremap <silent> <C-A> :ZoomToggle<CR>
" }}}

" Make sure Vim returns to the same line when you reopen a file.
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
"}}}

