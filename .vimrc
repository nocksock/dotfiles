" encoding: utf 8
"
" This is my messy .vimrc
"
" Author: Nils Riedemann
" Website: https://bleepbloop.studio/
" Repository: https://github.com/nocksock/dotfiles

" -- Plugins --------------------------------------------------------------- {{{

" install plug-vim if not present {{{

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" }}}

" auto pairs {{{

" auto insert/delete brackets, parens, quotes etc
Plug 'jiangmiao/auto-pairs'

" }}}
" git blamer {{{

" A git blame plugin for neovim inspired by VS Code's GitLens plugin
Plug 'APZelos/blamer.nvim'

" }}}
" vim closetag {{{

" automatically close tags
Plug 'alvan/vim-closetag'                                                       " Autoclose HTML Tags - with some smartness

" }}}
" vim closetag config {{{

" filenames like *.xml, *.html, *.xhtml, ...
" These are the file extensions where this plugin is enabled.
"
let g:closetag_filenames = '*.html,*.xhtml,*.phtml'

" filenames like *.xml, *.xhtml, ...
" This will make the list of non-closing tags self-closing in the specified files.
"
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx'

" filetypes like xml, html, xhtml, ...
" These are the file types where this plugin is enabled.
"
let g:closetag_filetypes = 'html,xhtml,phtml'

" filetypes like xml, xhtml, ...
" This will make the list of non-closing tags self-closing in the specified files.
"
let g:closetag_xhtml_filetypes = 'xhtml,jsx'

" integer value [0|1]
" This will make the list of non-closing tags case-sensitive (e.g. `<Link>` will be closed while `<link>` won't.)
"
let g:closetag_emptyTags_caseSensitive = 1

" dict
" Disables auto-close if not in a "valid" region (based on filetype)
"
let g:closetag_regions = {
    \ 'typescript.tsx': 'jsxRegion,tsxRegion',
    \ 'javascript.jsx': 'jsxRegion',
    \ 'typescriptreact': 'jsxRegion,tsxRegion',
    \ 'javascriptreact': 'jsxRegion',
    \ }

" Shortcut for closing tags, default is '>'
"
let g:closetag_shortcut = '>'

" Add > at current position without closing the current tag, default is ''
"
let g:closetag_close_shortcut = '<leader>>'
""}}}
" coc {{{

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'antoinemadec/coc-fzf'

let g:coc_global_extensions = [
    \   'coc-css',
    \   'coc-deno',
    \   'coc-emmet',
    \   'coc-eslint',
    \   'coc-git',
    \   'coc-go',
    \   'coc-html',
    \   'coc-jest',
    \   'coc-json',
    \   'coc-jsref',
    \   'coc-yank',
    \   'coc-pairs',
    \   'coc-php-cs-fixer',
    \   'coc-phpls',
    \   'coc-rls',
    \   'coc-sh',
    \   'coc-sql',
    \   'coc-svg',
    \   'coc-tsserver',
    \   'https://github.com/rodrigore/coc-tailwind-intellisense',
    \ ]

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Run jest for current project
command! -nargs=0 Jest :call  CocAction('runCommand', 'jest.projectTest')

" Run jest for current file
command! -nargs=0 JestCurrent :call  CocAction('runCommand', 'jest.fileTest', ['%'])

" Init jest in current cwd, require global jest command exists
command! JestInit :call CocAction('runCommand', 'jest.init')


"}}}
" vim-commentary {{{

" comment stuff out and back in via gc/gcc
Plug 'tpope/vim-commentary'

" }}}
" .editorconfig {{{

" loadsd settings from .editoconfig if present
Plug 'editorconfig/editorconfig-vim'

" }}}
" emmet {{{

" h1{emmet is awesome}+ul>li{It is!}*3
Plug 'mattn/emmet-vim'
let g:user_zen_leader_key = '<c-y>'

" }}}
" eunuch {{{

" Vim sugar for the UNIX shell commands that need it the most. Like:
"   :Delete, :Move, :Chmod
Plug 'tpope/vim-eunuch'

" }}}
" floaterm {{{

Plug 'voldikss/vim-floaterm'
let g:floaterm_keymap_new = '<c-\>;'

" }}}
" git: fugitive and rhubarb {{{

" a git wrapper in vim
Plug 'tpope/vim-fugitive'

" specials for github
Plug 'tpope/vim-rhubarb'

""}}}
" FZF {{{

" fzf <3 rip ctrlp
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" git branches etc
Plug 'stsewd/fzf-checkout.vim'

let g:fzf_layout = { 'up': '~90%', 'window': { 'width': 0.8, 'height': 0.8, 'yoffset':0.5, 'xoffset': 0.5 } }
let g:fzf_preview_window = ['up:50%', 'ctrl-/']
let $FZF_DEFAULT_OPTS = '--layout=reverse --info=inline'

command! FF call fzf#run(fzf#wrap({'source' : 'find .'}))

" use rg which respects .gitignore files
command! -bang -nargs=? -complete=dir Files
    \ call fzf#run(fzf#wrap('files', fzf#vim#with_preview({ 'dir': <q-args>, 'sink': 'e', 'source': 'rg --files --hidden' }), <bang>0))

" Add an AllFiles command that disrepsects .gitignore files
command! -bang -nargs=? -complete=dir AllFiles
    \ call fzf#run(fzf#wrap('allfiles', fzf#vim#with_preview({ 'dir': <q-args>, 'sink': 'e', 'source': 'rg --files --hidden --no-ignore' }), <bang>0))

""}}}
" gundo {{{

" undo tree - who needs version control, when you have vim?
Plug 'sjl/gundo.vim'

" }}}
" styled components {{{

" syntax hilighting in styled`` template literals
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
let g:vim_jsx_pretty_highlight_close_tag = 1

" }}}
" Polyglot {{{
" A collection of language packs for Vim.
"
" Adds about 10ms of loading time, but more comfortable than adding all the
" languages myself - and makes peeking into unknown languages easier.
"
" includes plugins that I previously had installed manually, like:
" html5.vim, vim-graphql, vim-ledger, yats, vim-javascript

" disabling needs to happen before loading. The included syntax highlights don't
" provide the level of control i'd like to have, so i'm currently using my own
let g:polyglot_disabled = ['python.plugin']

Plug 'sheerun/vim-polyglot'

""}}}
" repeat {{{

" makes . even more powerful by adding suppor for plugins
Plug 'tpope/vim-repeat'

" }}}
" surround {{{

" quoting/parenthesizing made simple. Extends functionality of S
Plug 'tpope/vim-surround'

" }}}
" python {{{

" This is my custom python-vim fork. I don't agree with some of the highlight
" groups and wanted more control of some specifics for my custom colorscheme.
" using a relative path makes it easier to adjust and test things on the fly.
Plug '~/projects/python-vim'

" }}}
" table mode {{{

" not as good as org mode's table stuff, but at least makes formatting complex
" ascii tables easier.
Plug 'dhruvasagar/vim-table-mode'

" }}}
" tabular {{{

" align text at character. more powerful than :!column
Plug 'godlygeek/tabular'

" }}}
" ultisnips {{{

" current snippet handler of choice. has some features that coc-snippets won't
" or cannot implement.
Plug 'SirVer/ultisnips'

" }}}
" vinegar {{{

" improved netrw for file browsing. fun fact: it's one of the plugins that made
" me stick to vim back in the day for the first time.
Plug 'tpope/vim-vinegar'

" }}}
" bloop {{{

" my own colorscheme, work in progress
" Plug 'nocksock/bloop-vim'
Plug '~/projects/bloop-vim'

" }}}
" lightline {{{

Plug 'itchyny/lightline.vim'
Plug 'itchyny/vim-gitbranch'

function! LightlineReload()
  call lightline#init()
  call lightline#colorscheme()
  call lightline#update()
endfunction

fun! CustomizeLightline()
  let g:lightline = {
        \   'colorscheme': 'bloop',
        \   'active': {
        \     'left': [ [ 'mode', 'paste' ],
        \               [ 'gitbranch', ], ['readonly', 'path', 'modified']],
        \     'right': [['filetype', 'percent', 'lineinfo']],
        \   },
        \   'component': {
        \     'path': '%<%f'
        \   },
        \   'component_function': {
        \     'gitbranch': 'gitbranch#name',
        \     'cocstatus': 'coc#status'
        \   },
        \   'mode_map': {
        \     'n' : 'N',
        \     'i' : 'I',
        \     'R' : 'R',
        \     'v' : 'v',
        \     'V' : 'V',
        \     "\<C-v>": 'B',
        \     'c' : 'C',
        \     's' : 's',
        \     'S' : 'S',
        \     "\<C-s>": 'S',
        \     't': '$'
        \   }
        \ }

  let g:lightline.subseparator = { 'left': '', 'right': '' }
  call LightlineReload()
endfun

augroup user_lightline
  au!
  au User CocStatusChange,CocDiagnosticChange call lightline#update()
  au User PlugLoaded call CustomizeLightline()
augroup END

" }}}

call plug#end()

doautocmd User PlugLoaded

"}}}

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
set noincsearch
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
set noshowmode                                           " Don't show mode (insert, visual etc) on the last line. Is handled by lightline
set smartcase
set softtabstop=2
set splitbelow                                           " When on, splitting a window will put the new window below the current one
set synmaxcol=500                                        " Until which column vim parses syntax
set t_Co=256                                             " term colors
set t_ut=
set tabstop=2
set termguicolors                                        " enable 24bit colors
set textwidth=80
set updatetime=1000                                      " how often to write swapfiles - some plugins, eg git-gutter use this for their update interval too
set wildignore+=*.DS_Store                               " OSX bullshit
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg           " binary images
set wildignore+=*.sw?                                    " Vim swap files
set wildignore+=.hg,.git,.svn                            " Version control
set wildmenu
set wildmode=longest,list,full

syntax on

colors bloop

" use different undo directory for vim/nvim since they're not compatible
if has('nvim')
  set undodir=~/.nvim/tmp/undo/
else
  set undodir=~/.vim/tmp/undo/
  " Don't clutter my dirs up with swp and tmp files
  set directory=~/.vim/tmp

  " enable italics in vim. works by default in nvim
  let &t_ZH="\e[3m"
  let &t_ZR="\e[23m"

  " sometimes setting termguicolors for true color support  is not enough see
  " :he t_8b
  set t_8b=[48;2;%lu;%lu;%lum
  set t_8f=[38;2;%lu;%lu;%lum
endif

set undofile

" }}}

" -- custom functions and command definitions ------------------------------ {{{

function! SynStack()
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

" gx to open github urls in browser
function! s:plug_gx()
  let line = getline('.')
  let sha  = matchstr(line, '^  \X*\zs\x\{7,9}\ze ')
  let name = empty(sha) ? matchstr(line, '^[-x+] \zs[^:]\+\ze:')
                      \ : getline(search('^- .*:$', 'bn'))[2:-2]
  let uri  = get(get(g:plugs, name, {}), 'uri', '')
  if uri !~ 'github.com'
    return
  endif
  let repo = matchstr(uri, '[^:/]*/'.name)
  let url  = empty(sha) ? 'https://github.com/'.repo
                      \ : printf('https://github.com/%s/commit/%s', repo, sha)
  call netrw#BrowseX(url, 0)
endfunction

" }}}

" -- Key Mappings ---------------------------------------------------------- {{{

" Window Management "{{{

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

nmap <leader>bd :bd<cr>
nmap <leader>bp :bp<cr>
nmap <leader>bn :bn<cr>
nmap <leader>ba :e #<cr>

nmap <leader>dts mz:%s/ \+$//<cr>`z<cr>

" Go to last active tab
au TabLeave * let g:lasttab = tabpagenr()

nnoremap <silent> <c-l> :exe "tabn ".g:lasttab<cr>
vnoremap <silent> <c-l> :exe "tabn ".g:lasttab<cr>
tnoremap      <c-\>   <C-\><C-n>:FloatermToggle<CR>
nnoremap      <c-\>   <C-J><C-n>:FloatermToggle<CR>

"}}}
" coc {{{

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> <leader>di <Plug>(coc-diagnostic-info)
nmap <silent> <leader>dn <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>dp <Plug>(coc-diagnostic-next)
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" git hunks
nmap <silent> <leader>hn <Plug>(coc-git-nextchunk)
nmap <silent> <leader>hp <Plug>(coc-git-prevchunk)

" apply autofix to problem on the current line.
nmap <leader>am  <plug>(coc-format-selected)
xmap <leader>am  <plug>(coc-format-selected)
nmap <leader>ca  <Plug>(coc-codeaction-cursor)
nmap <leader>cf  <plug>(coc-fix-current)
nmap <leader>ci :call CocAction('runCommand', 'editor.action.organizeImport')<cr>

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>ga  <Plug>(coc-codeaction-line)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Remap <C-f> and <C-b> for scroll float windows/popups.
nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"

" show CocList via Fzf
nmap <leader>ll :CocFzfList<cr>
nmap <leader>la :CocFzfList actions<cr>
nmap <leader>lc :CocFzfList commands<cr>
nmap <leader>lo :CocFzfList outline<cr>
nmap <leader>ls :CocFzfList snippets<cr>
nmap <leader>ld :CocFzfList diagnostics<cr>
nmap <leader>lr :CocFzfList resume<cr>
nmap <leader>ly :CocFzfList yank<cr>

" show yanks list
nnoremap <silent> <space>yl  :<C-u>CocFzfList yank<cr>

" clean yanks
nnoremap <silent> <space>yc  :CocCommand yank.clean

nnoremap <silent> <leader>pp :w<cr>:CocCommand prettier.formatFile<cr>

" Make <tab> used for trigger completion, completion confirm, snippet expand and
" jump like VSCode
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Run jest for current test
nnoremap <leader>tt :call CocAction('runCommand', 'jest.singleTest')<CR>

""}}}
" FZF {{{{


nnoremap <leader><space> :Files<cr>
nnoremap <leader>ff :Files<cr>
nnoremap <leader>fa :AllFiles<cr>
noremap <leader>fr :History<cr>
noremap <leader>fl :Lines<cr>
noremap <leader>ft :Tags<cr>
noremap <leader>hh :Helptags<cr>
noremap <leader>ss :Ag<cr>
noremap <leader>bb :Buffers<cr>
noremap <leader>sn :Snippets<cr>
nmap <leader>gb :GBranches<cr>

" muscle memory keeper for vscode moments
noremap <c-p> :Files<cr>

" }}}}
" Movements {{{
" zoom to head level with a bit of context
nnoremap zh mzzt5<c-u>`z

" motion: select all or the inside of folds
xnoremap az [zo]z
xnoremap iz [zjo]zk

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
" quick edits (prefix: e) {{{

noremap <leader>ev :tabnew ~/dotfiles/.vimrc<CR>
noremap <leader>ez :tabnew ~/dotfiles/.zshrc<CR>
noremap <leader>et :tabnew ~/dotfiles/.tmux.conf<CR>
noremap <leader>ec :tabnew ~/dotfiles/.vim/coc-settings.json<CR>
noremap <leader>es :UltiSnipsEdit<CR>
noremap <leader>rr :source ~/.vimrc<CR>

""}}}
" miscallaneous {{{

" Easy insertion of a trailing ; or , from insert mode
imap ;; <Esc>A;<Esc>
imap ,, <Esc>A,<Esc>

" Reselect visual selection after indenting
vnoremap < <gv
vnoremap > >gv

" open file under cursor, even if not existing
" map gf :edit <cfile><cr>

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

" delete without yanking
nnoremap <leader>d "_d
vnoremap <leader>d "_d

" replace currently selected text with default register
" without yanking it
vnoremap <leader>p "_dP

" keep muscle memory for saving often
noremap <c-s> :w<cr>
inoremap <c-s> <esc>:w<cr>i

noremap <leader>tg :set notermguicolors<cr>

" commenting
" NOTE: for some reason vim registers c-/ as c-_
" TODO: properly keep cursor position based on comment syntax # vs //
imap <c-_> <esc>mzgcc`zl
nmap <c-_> mzgcc`zl
vmap <c-_> mzgc`zgv

" search for word under cursor - without jumping to next or adding a jump in the
" jumplist. Useful in combination with cgn.
nnoremap * :keepjumps normal! mi*`i<CR>

noremap <leader>ts :call SynStack()<cr>
" Git bindings
noremap <leader>gg :Git<cr>

noremap <leader>gl :BlamerToggle<cr>
" }}}

" }}}

" -- Config Meta ----------------------------------------------------------- {{{

" load local .vim if present
let b:thisdir=expand("%:p:h")
let b:vim=b:thisdir."/.vim"
if (filereadable(b:vim))
    execute "source ".b:vim
    echom "loaded local .vim"
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

" -- file types ------------------------------------------------------------{{{

" -- javascript ------------------------------------------------------------ {{{

" force vim to parse the *entire* file from start. should fix seemingly
" unmatched braces etc.
autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear

augroup ft_javascript
    au!
    au FileType javascript setlocal foldmethod=marker
    au FileType javascript setlocal foldmarker={,}
    au FileType javascript :au InsertLeave *.js setlocal nolist
    au FileType javascript :au InsertEnter *.js setlocal list
augroup END

""}}}

" -- zsh-------------------------------------------------------------------- {{{

augroup ft_zsh
    au!
    au BufNewFile,BufRead *.zsh-theme setlocal filetype=zsh
augroup END

""}}}

" -- vimrc ----------------------------------------------------------------- {{{

augroup ft_vimrc
  autocmd!
  autocmd FileType vim nnoremap <buffer> <silent> gx :call <sid>plug_gx()<cr>
augroup END

""}}}

" }}}
