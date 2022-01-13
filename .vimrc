"
" This is my messy but also very large .vimrc
"
" Author: Nils Riedemann
" Website: https://bleepbloop.studio/
" Repository: https://github.com/nocksock/dotfiles
"
" ------------------------------------------------------------------------------

" -- Plugins --------------------------------------------------------------- {{{
" I use a LOT of plugins. Some I consider essential, and some I only use in rare
" occasions.
"
" I tried using the structure, where you'd have a .vim file for each plugin and
" configure each plugin there, with keymaps and all. But in the end I didn't
" find it as quick as just jumping around this file with markers, and having key
" mappings in different files didn't give me the overview I hoped it'd give.

" install plug-vim if not present {{{

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" }}}

" Stable essentials
"
" These are small plugins that I have been using for years now and often forget
" are not even part of vim. Most of them just add behaviour that works passive
" and requires little to no config and do not rely on external programs.

" vinegar {{{

" improved netrw for file browsing. fun fact: it's one of the plugins that made
" me stick to vim back in the day for the first time.
Plug 'tpope/vim-vinegar'

" }}}
" git: fugitive and rhubarb {{{

" a git wrapper in vim
Plug 'tpope/vim-fugitive'

" specials for github
Plug 'tpope/vim-rhubarb'

""}}}
" repeat {{{

" makes . even more powerful by adding suppor for plugins
Plug 'tpope/vim-repeat'

" }}}
" surround {{{

" quoting/parenthesizing made simple. Extends functionality of S
Plug 'tpope/vim-surround'

" }}}
" ultisnips {{{

" current snippet handler of choice. has some features that coc-snippets won't
" or cannot implement.
Plug 'SirVer/ultisnips'

let g:UltiSnipsExpandTrigger="<c-l>"
let g:UltiSnipsJumpForwardTrigger="<c-l>"
let g:UltiSnipsJumpBackwardTrigger="<c-h>"

" }}}
" commentary {{{

" comment stuff out and back in via gc/gcc
Plug 'tpope/vim-commentary'

" }}}
" auto pairs {{{

" auto insert/delete brackets, parens, quotes etc
Plug 'jiangmiao/auto-pairs'

" }}}
" vim closetag {{{

" automatically close tags
Plug 'alvan/vim-closetag'                                                       " Autoclose HTML Tags - with some smartness

" config {{{

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

" }}}
" emmet {{{

" h1{emmet is awesome}+ul>li{It is!}*3
Plug 'mattn/emmet-vim'
let g:user_zen_leader_key = '<c-y>'

" }}}

" Current Core Workflow Plugins
"
" these pretty much define how I mostly work within vim right now, but require
" extensive configuration and rely on external dependencies that might not be
" available/installable on some machines

" coc {{{
" LSP is one of the best things in recent years or so. While the builtin version
" is great, some coc-extensions are just crazy good and are things I otherwise
" would miss from VS Code (eg. jsref to toggle implicit and explicit return
" statements for arrow functions). Also it feels like coc just works better
" out-of-the-box atm than LSP.

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'antoinemadec/coc-fzf'

let g:coc_global_extensions = [
    \   'coc-css',
    \   'coc-emmet',
    \   'coc-eslint',
    \   'coc-git',
    \   'coc-html',
    \   'coc-jest',
    \   'coc-json',
    \   'coc-jsref',
    \   'coc-pairs',
    \   'coc-svg',
    \   'coc-php-cs-fixer',
    \   'coc-sql',
    \   'https://github.com/rodrigore/coc-tailwind-intellisense',
    \   'coc-go',
    \   'coc-rls',
    \   'coc-pyright',
    \   'coc-deno',
    \   'coc-sh',
    \   'coc-phpls',
    \   'coc-prisma',
    \   'coc-tsserver',
    \ ]

let g:coc_disable_transparent_cursor = 1

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
" FZF {{{
" FZF is one of those things, that "just make sense"". I've been using CTRL-P
" before that for years to fuzzy find files, but FZF seems much faster (using
" rg/ag in the back) and it has an interface that can be used for other things
" than file finding.
"
" I'd consider it almost a stable essential for me at this point, but it has an
" external dependency fzf so it doesn't quite fit along the other ones and also
" requires a lot of configuration and key mapping.

" fzf <3 rip ctrl-p
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" git branches etc
Plug 'stsewd/fzf-checkout.vim'

let g:fzf_layout = { 'up': '~90%', 'window': { 'width': 0.8, 'height': 0.8, 'yoffset':0.5, 'xoffset': 0.5 } }
let g:fzf_preview_window = ['up:50%', 'ctrl-/']
let $FZF_DEFAULT_OPTS = '--layout=reverse --info=inline'

command! FF call fzf#run(fzf#wrap({'source' : 'find .'}))

" Add an AllFiles command that disrepsects .gitignore files
command! -bang -nargs=? -complete=dir AllFiles
    \ call fzf#run(fzf#wrap('allfiles', fzf#vim#with_preview({ 'dir': <q-args>, 'sink': 'e', 'source': 'rg --files --hidden --no-ignore' }), <bang>0))

""}}}

" Niceties
"
" just some nice things that I could easily do without.

" git blamer {{{

" A git blame plugin for neovim inspired by VS Code's GitLens plugin
Plug 'APZelos/blamer.nvim'

" }}}
" .editorconfig {{{

" loadsd settings from .editoconfig if present
Plug 'editorconfig/editorconfig-vim'

" }}}
" floaterm {{{

Plug 'voldikss/vim-floaterm'
let g:floaterm_keymap_new = '<c-\>;'

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
" eunuch {{{

" Vim sugar for the UNIX shell commands that need it the most. Like:
"   :Delete, :Move, :Chmod
Plug 'tpope/vim-eunuch'

" }}}
" gundo {{{

" undo tree - who needs version control, when you have vim?
Plug 'sjl/gundo.vim'

" }}}
" styled components {{{

" syntax hilighting in styled`` template literals
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
let g:vim_jsx_pretty_highlight_close_tag = 1

" }}}

" Colors, syntax and themes
"
" These make vim and syntax highlighting look nice.

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
" prisma {{{
Plug 'pantharshit00/vim-prisma'
" }}}
" python {{{

" This is my custom python-vim fork. I don't agree with some of the highlight
" groups and wanted more control of some specifics for my custom colorscheme.
" using a relative path makes it easier to adjust and test things on the fly.
Plug '~/projects/python-vim'

" }}}
" bloop {{{

" my own colorscheme, work in progress
" Plug 'nocksock/bloop-vim'
Plug '~/projects/bloop-vim'

" }}}
" lightline {{{

Plug 'itchyny/lightline.vim'
Plug 'itchyny/vim-gitbranch'

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

augroup user_lightline
  au!
  au User CocStatusChange,CocDiagnosticChange call lightline#update()
augroup END

" }}}

call plug#end()

" }}}

" -- Basic options --------------------------------------------------------- {{{
let mapleader = "\<space>"
let maplocalleader = ","

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
set expandtab                                            " use spaces for indentation by default
set foldenable
set foldlevelstart=1  " default for how many folds levels should be open
set foldmethod=marker  " use markers (tripple curly braces unless changed) for folding
set foldnestmax=10
set formatoptions=qrn1
set gdefault                                             " add g flag by default for :substitutions
set hidden                                               " enable hidden buffers - so i can switch buffers even if current is changed.
set hlsearch
set ignorecase
set noincsearch                                          " disable incremental search that would make vim jump around while typing. Kinda got disoriented by it
set laststatus=2                                         " Always show status line.
set list                                                 " Show invisible characters                                                                         "
set listchars=tab:\|⋅,eol:¬,trail:-,extends:↩,precedes:↪ " define characters for invisible characters
set mouse=a                                              " enable scrolling and selecting with mouse
set nocursorline                                         " Highlight the line of in which the cursor is present (or not)
set noswapfile                                           " It's 2012, Vim.
set nowrap                                               " don't wrap text around when the window is too small
set nu rnu                                               " show *HYBRID* line numbers, relative line numbers + current line number
set ruler                                                " show the cursor position all the time
set shell=/bin/zsh                                       " set default shell for :shell
set shiftround                                           " When at 3 spaces and I hit >>, go to 4, not 5.
set shiftwidth=2
set showcmd                                              " display incomplete commands
set scrolloff=2                                          " always have 2 lines more visible when reaching top/end of a window when scrolling
set showmatch                                            " Highlight matching bracket
set noshowmode                                           " Don't show mode (insert, visual etc) on the last line. Is handled by lightline
set smartcase                                            " ignore 'ignorecase' when search contains uppercase characters
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

" -- Custom functions and command definitions ------------------------------ {{{

" reload lightline entirely - useful when changing its configuration
function! LightlineReload()
  call lightline#init()
  call lightline#colorscheme()
  call lightline#update()
endfunction

" get some of the highlight groups for the current cursor position
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
" This is a messy mess. I will find a nicer way of structuring them at some
" point, but for now losely grouping them will do. Trying to come up with
" a cohesive system loosely based around prefixes and scopes.

" b: Buffers {{{

nmap <leader>bd :bd<cr>
nmap <leader>bp :bp<cr>
nmap <leader>bn :bn<cr>
nmap <leader>ba :e #<cr>

" }}}
" c: Code actions {{{

" apply autofix to problem on the current line.
nmap <leader>am  <plug>(coc-format-selected)
nmap <leader>ca  <Plug>(coc-codeaction-cursor)
nmap <leader>cf  <plug>(coc-fix-current)
nmap <leader>ci :call CocAction('runCommand', 'editor.action.organizeImport')<cr>
nnoremap <leader>cp :w<cr>:CocCommand prettier.formatFile<cr>

" Symbol renaming.
nmap <leader>cn <Plug>(coc-rename)

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>ga  <Plug>(coc-codeaction-line)

" }}}
" d: diagnostics {{{

" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> <leader>di <Plug>(coc-diagnostic-info)
nmap <silent> <leader>dn <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>dp <Plug>(coc-diagnostic-next)

" Use `[g` and `]g` to navigate diagnostics.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" }}}
" e: edit {{{

noremap <leader>ev :tabnew ~/dotfiles/.vimrc<CR>
noremap <leader>ez :tabnew ~/dotfiles/.zshrc<CR>
noremap <leader>et :tabnew ~/dotfiles/.tmux.conf<CR>
noremap <leader>ec :tabnew ~/dotfiles/.vim/coc-settings.json<CR>
noremap <leader>es :UltiSnipsEdit<CR>
noremap <leader>rr :source ~/.vimrc<CR>

" }}}
" f, FZF {{{
" IDEA: maybe <prefix><prefix> as a rule to trigger fzf?

nnoremap <leader><space> :Files<cr>
nnoremap <leader>fa :AllFiles<cr>
nnoremap <leader>fb :Buffers<cr>
nnoremap <leader>ff :Files<cr>
nnoremap <leader>fg :GBranches<cr>
nnoremap <leader>fh :Helptags<cr>
nnoremap <leader>fl :Lines<cr>
nnoremap <leader>fn :Snippets<cr>
nnoremap <leader>fr :History<cr>
nnoremap <leader>fs :Ag<cr>
nnoremap <leader>ft :Tags<cr>

" muscle memory keeper for vscode moments
nnoremap <c-p> :Files<cr>

" }}}
" g: goto {{{

" gx to open links
nnoremap gx :execute '!open ' . shellescape(expand('<cWORD>'), 1)<cr>

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" }}}
" h: Hunks {{{

nmap <silent> <leader>hn <Plug>(coc-git-nextchunk)
nmap <silent> <leader>hp <Plug>(coc-git-prevchunk)

" }}}
" l: Lists {{{

" show CocList via Fzf
nmap <leader>ll :CocFzfList<cr>
nmap <leader>la :CocFzfList actions<cr>
nmap <leader>lc :CocFzfList commands<cr>
nmap <leader>lo :CocFzfList outline<cr>
nmap <leader>ls :CocFzfList snippets<cr>
nmap <leader>ld :CocFzfList diagnostics<cr>
nmap <leader>lr :CocFzfList resume<cr>
nmap <leader>ly :CocFzfList yank<cr>

" }}}
" t, Tabs {{{

nnoremap <C-t> <esc>:tabnew<cr>

nnoremap <leader>tn :tabnext<cr>
nnoremap <leader>tp :tabprevious<cr>
nnoremap <leader>tf :tabfirst<cr>
nnoremap <leader>tl :tablast<cr>

noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt

" Go to last active tab
au TabLeave * let g:lasttab = tabpagenr()

nnoremap <silent> <c-l> :exe "tabn ".g:lasttab<cr>
vnoremap <silent> <c-l> :exe "tabn ".g:lasttab<cr>

" }}}

" Autocomplete {{{

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

""}}}
" Movements and text objects {{{

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

" motion: select all or the inside of folds
xnoremap az [zo]z
xnoremap iz [zjo]zk

" Keep search matches in the middle of the window
nnoremap n nzzzv
nnoremap N Nzzzv

" C-R in visual mode to replace selected text
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

" highlight last inserted text
nnoremap gV `[v`]

" }}}
" Miscallaneous {{{

" toggle floaterm
tnoremap      <c-\>   <C-\><C-n>:FloatermToggle<CR>
nnoremap      <c-\>   <C-J><C-n>:FloatermToggle<CR>

" press jk to Esc - much faster while typing
inoremap jk <ESC>

" Run jest for current test
nnoremap <leader>tt :call CocAction('runCommand', 'jest.singleTest')<CR>

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

" Remap <C-f> and <C-b> for scroll float windows/popups.
nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"

" delete trailing spaces
nmap <leader>dts mz:%s/ \+$//<cr>`z<cr>

" Easy insertion of a trailing ; or , from insert mode
imap ;; <Esc>A;<Esc>
imap ,, <Esc>A,<Esc>

" Reselect visual selection after indenting
vnoremap < <gv
vnoremap > >gv

" open file under cursor, even if not existing
" map gf :edit <cfile><cr>

" clear highlight
noremap <leader>ch :nohl<cr>

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

" Auto source vim file when saved
autocmd! BufWritePost .vimrc source %

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

" -- File Type Specifcs ---------------------------------------------------- {{{

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
