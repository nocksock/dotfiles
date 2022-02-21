" Moin!
"
" This is my messy but *also* large .vimrc.
"
" Author: Nils Riedemann
" Website: https://bleepbloop.studio/
" Repository: https://github.com/nocksock/dotfiles
" EMail: nils@bleepbloop.studio
"
" Hit me up if you have questions about things in here or vim in general. I'd be
" happy to help or point in directions.
"

" Plugins {{{

" install plug-vim if not present
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" bunch of plugins without further configuration

Plug 'tpope/vim-fugitive' " a git wrapper in vim
Plug 'tpope/vim-abolish' " working with words
Plug 'tpope/vim-vinegar' " improved netrw for file browsing.
Plug 'tpope/vim-scriptease' " helpers for vim scripting and plugin authoring
Plug 'tpope/vim-surround' " quoting/parenthesizing made simple. Extends functionality of S
Plug 'tpope/vim-repeat' " makes . even more powerful by adding suppor for plugins
Plug 'tpope/vim-commentary' " comment stuff out and back in via gc/gcc
Plug 'tpope/vim-eunuch' " Vim sugar for the UNIX shell commands that need it the most. Like :Delete, :Move, :Chmod
Plug 'jiangmiao/auto-pairs' " auto insert/delete brackets, parens, quotes etc
Plug 'editorconfig/editorconfig-vim' " loads settings from .editoconfig if present
Plug 'godlygeek/tabular' " align text at character. more powerful than :!column
Plug 'simnalamburt/vim-mundo' " browser for vim's undo tree, for when git is not enough
Plug 'pantharshit00/vim-prisma' " syntax for prisma file
Plug 'voldikss/vim-floaterm' " floating terminal

Plug '~/projects/python-vim' " a fork of python-vim with some adjustments according to personal preferences
Plug 'nocksock/bloop-vim' " my own colorscheme, work in progress

" UltiSnips {{{

Plug 'SirVer/ultisnips'
let g:UltiSnipsExpandTrigger="<c-l>"
let g:UltiSnipsJumpForwardTrigger="<c-l>"
let g:UltiSnipsJumpBackwardTrigger="<c-h>"
let g:UltiSnipsSnippetStorageDirectoryForUltiSnipsEdit="~/.vim/UltiSnips"

" }}}
" vim closetag {{{
" Autoclose HTML Tags - with some smartness

Plug 'alvan/vim-closetag'
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

" }}}
" coc {{{
" Nodejs extension host to load extension like vscode does and host language
" server. Provides a lot of useful commands.

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
      \   'coc-prettier',
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

command! -nargs=0 Format :call CocAction('format') " Add `:Format` command
command! -nargs=? Fold :call CocAction('fold', <f-args>) " Add `:Fold` command to fold current buffer.
command! -nargs=0 Jest :call CocAction('runCommand', 'jest.projectTest') " Run jest for current project
command! -nargs=0 JestCurrent :call CocAction('runCommand', 'jest.fileTest', ['%']) " Run jest for current file
command! JestInit :call CocAction('runCommand', 'jest.init') " Init jest in current cwd, require global jest command exists
command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport') " Add `:OR` command for organize imports of the current buffer.

"}}}
" FZF {{{
" The glorious file finder integrated directly in vim

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'stsewd/fzf-checkout.vim' " git branches etc

let g:fzf_layout = { 'up': '~90%', 'window': { 'width': 0.8, 'height': 0.8, 'yoffset':0.5, 'xoffset': 0.5 } }
let g:fzf_preview_window = ['up:50%', 'ctrl-/']
let $FZF_DEFAULT_OPTS = '--layout=reverse --info=inline'

" }}}

" Polyglot
" --------
" A collection of language packs for Vim. Adds about 10ms of loading time, but
" more comfortable than adding all the languages myself - and makes peeking into
" unknown languages easier.

let g:polyglot_disabled = ['python.plugin'] " disable python in favor of my own
let g:vim_jsx_pretty_highlight_close_tag = 1 " enable highlitght

Plug 'sheerun/vim-polyglot'

" lightline {{{
" easy to configure status bar for vim

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
          \     'path': '%<%f',
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
" Basic options {{{
let mapleader = "\<space>"
let maplocalleader = "\<c-@>"   " use ctrl-space as local leader

set autoindent                                           " Copy indent from current line when creating a new line                                            "
set autoread                                             " auto re-read file when it changed outside of vim, but not inside
set backspace=indent,eol,start                           " allow backspacing over everything in insert mode
set backup                                               " enable backups
set backupdir=/tmp
set backupdir=~/.vim/tmp/backup/                         " backups
set backupskip=/tmp/*,/private/tmp/*                     " Make Vim able to edit crontab files again.
set breakindent                                          " wrapped lines appear indendet
" set clipboard=unnamed                                    " using * as default register - which makes system wide copy paste possible
set encoding=utf-8
set expandtab                                            " use spaces for indentation by default
set foldenable
set foldmethod=marker  " use markers (tripple curly braces unless changed) for folding
set foldnestmax=10
set formatoptions=qrn1j " format options when writing, joining lines or `gq` see  :he fo-table for meanings
set gdefault                                             " add g flag by default for :substitutions
set hidden                                               " enable hidden buffers - so i can switch buffers even if current is changed.
set history=10000 " keep way more commands in history
set hlsearch
set incsearch                                           " enable incremental search that would make vim jump around while typing
set laststatus=2                                         " Always show status line.
set list                                                 " Show invisible characters
set listchars=tab:\|⋅,eol:¬,trail:-,extends:↩,precedes:↪ " define characters for invisible characters
set mouse=a                                              " enable scrolling and selecting with mouse
set nocursorline                                         " Highlight the line of in which the cursor is present (or not)
set noshowmode                                           " Don't show mode (insert, visual etc) on the last line. Is handled by lightline
set noswapfile                                           " It's 2012, Vim.
set nowrap                                               " don't wrap text around when the window is too small
set nu rnu                                               " show *HYBRID* line numbers, relative line numbers + current line number
set ruler                                                " show the cursor position all the time
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
set t_Co=256                                             " term colors
set t_ut=
set tabstop=2
set termguicolors                                        " enable 24bit colors
set textwidth=80
set undofile
set updatetime=1000                                      " how often to write swapfiles - some plugins, eg git-gutter use this for their update interval too
set wildignore+=*.DS_Store                               " OSX bullshit
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg           " binary images
set wildignore+=*.sw?                                    " Vim swap files
set wildignore+=.hg,.git,.svn                            " Version control
set wildmenu
set wildmode=longest,list,full

let g:netrw_altfile=1 " make CTRL-^ ignore netrw buffers

syntax on
colors bloop

" use different undo directory for vim/nvim since they're not compatible
if has('nvim')
  set undodir=~/.nvim/tmp/undo/
else
  set undodir=~/.vim/tmp/undo/
  set directory=~/.vim/tmp " Don't clutter my dirs up with swp and tmp files

  " enable italics in vim. works by default in nvim
  let &t_ZH="\e[3m"
  let &t_ZR="\e[23m"

  " sometimes setting termguicolors for true color support  is not enough see
  " :he t_8b
  set t_8b=[48;2;%lu;%lu;%lum
  set t_8f=[38;2;%lu;%lu;%lum
endif

" }}}
" Custom functions and command definitions {{{

" reload lightline entirely - useful when changing its configuration
function! LightlineReload()
  call lightline#init()
  call lightline#colorscheme()
  call lightline#update()
endfunction

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

" Add an AllFiles command that disrepsects .gitignore files
command! -bang -nargs=? -complete=dir AllFiles
      \ call fzf#run(fzf#wrap('allfiles',
      \ fzf#vim#with_preview({ 'dir': <q-args>, 'sink': 'e', 'source': 'rg --files --hidden --no-ignore' })
      \ , <bang>0))

" overwrite :Ag and prevent it from searching filenames
command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0)

command! -bang -nargs=? -complete=file Notes
      \ call fzf#run(fzf#wrap('notes',
      \ fzf#vim#with_preview({ 'source': 'ag ~/notes ', 'sink': 'e' }),
      \ <bang>0))

" Only search for .tsx files. Helpful in large codebases with lots of components
command! -bang -nargs=? -complete=file Components
      \ call fzf#run(fzf#wrap('components', fzf#vim#with_preview({ 'source': 'find . -type f \( -iname "*.tsx" -not -iname "*.spec.tsx" \) ' }), <bang>0))

command! C Components
command! H Helptags
command! B Buffers
command! GG :tab G

" }}}
" mappings and motions {{{

" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)
omap ig <Plug>(coc-git-chunk-inner)
xmap ig <Plug>(coc-git-chunk-inner)
omap ag <Plug>(coc-git-chunk-outer)
xmap ag <Plug>(coc-git-chunk-outer)

" goto
nmap gs <Plug>(coc-git-chunkinfo)
nmap gb <Plug>(coc-git-commit)
nmap gd <Plug>(coc-definition)
nmap gy <Plug>(coc-type-definition)
nmap gi <Plug>(coc-implementation)
nmap gr <Plug>(coc-references)
nmap gx :execute '!open ' . shellescape(expand('<cWORD>'), 1)<cr>

" navigation
nmap [d <Plug>(coc-diagnostic-prev)
nmap ]d <Plug>(coc-diagnostic-next)
nmap [g <Plug>(coc-git-prevchunk)
nmap ]g <Plug>(coc-git-nextchunk)
nmap [c <Plug>(coc-git-prevconflict)
nmap ]c <Plug>(coc-git-nextconflict)

nmap [t :tabprevious<cr>
nmap ]t :tabnext<cr>
nmap [T :tabfirst<cr>
nmap ]T :tablast<cr>

nmap [b :bprevious<cr>
nmap ]b :bnext<cr>
nmap [B :bfirst<cr>
nmap ]B :blast<cr>

" type %% in vim's prompt to insert %:h expanded
cmap <expr> %%  getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" Keep search matches in the middle of the window
nmap n nzzzv
nmap N Nzzzv

" highlight last inserted text
nmap gV `[v`]

" leader prefix
" -------------
" I'm trying to use less of these and use commands instead since they're more
" flexible, easier to discover and remember too. Some of these should rather be
" operators anyway.

" Just a few that I feel add a lot of efficiency or comfort.
nmap <leader>f :Ag<cr>
nmap <leader><leader> :Files<cr>
nmap <leader>; :terminal ++rows=15<cr>
nmap <leader>gs :tab G<cr>
nmap <leader>/ :nohl<cr>
nmap <leader>ll :CocFzfList<cr>
nmap <leader>ld :CocFzfList diagnostics<cr>
nmap <leader>lo :CocFzfList outline<cr>
nmap <leader>ls :CocList symbols<cr>

" TODO: consider turning these into motions/operators {{{
nmap <leader>dts mz:%s/ \+$//<cr>`z<cr> | " delete trailing spaces
nmap <leader>ca  <Plug>(coc-codeaction-cursor)
nmap <leader>ci :call CocAction('runCommand', 'editor.action.organizeImport')<cr>
nmap <leader>cp :w<cr>:CocCommand prettier.formatFile<cr>
nmap <leader>cr <Plug>(coc-rename)
nmap <leader>di <Plug>(coc-diagnostic-info)
nmap <leader>cs :CocCommand git.chunkStage<cr>
nmap <leader>cu :CocCommand git.chunkUndo<cr>
nmap <leader>ga <Plug>(coc-codeaction-line)
" }}}

nmap <silent> <F12> :FloatermToggle<CR>
tmap <silent> <F12> <C-\><C-n>:FloatermToggle<CR>

" for muscle memory
nmap <c-s> :w<cr>
imap <c-s> <esc>:w<cr>i

" Use K to show documentation in preview window.
nmap <silent> K :call <SID>show_documentation()<CR>

" Easy insertion of a trailing ; or , from insert mode
inoremap ;; <Esc>A;<Esc>
inoremap ,, <Esc>A,<Esc>

" search for word under cursor without jumping
nnoremap * :keepjumps normal! mi*`i<CR>

" }}}
" Config Meta {{{

" load local .vim if present
let b:thisdir=expand("%:p:h")
let b:vim=b:thisdir."/.vim"
if (filereadable(b:vim))
  execute "source ".b:vim
  echom "loaded local .vim"
endif

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
" File Type Specifcs {{{
" [j|t]sx? {{{

augroup ft_jtsx
  au!

  au BufNewFile,BufRead *.ts setlocal filetype=typescript
  au BufNewFile,BufRead *.js setlocal filetype=javascript.jsx
  au BufNewFile,BufRead *.tsx setlocal filetype=typescript.tsx

  " force vim to parse the *entire* file from start. should fix seemingly
  " unmatched braces etc.
  autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
  autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear

  au FileType javascript setlocal formatprg=prettier\ --parser\ typescript
  au FileType javascript nmap <localleader>s :e %:r:r.stories.js<cr>
  au FileType javascript nmap <localleader>t :e %:r:r.spec.js<cr>
  au FileType javascript nmap <localleader>m :e %:r:r.js<cr>

  au FileType javascript.jsx setlocal foldmethod=syntax
  au InsertLeave javascript.jsx setlocal nolist
  au InsertEnter javascript.jsx setlocal list
  au FileType javascript.jsx nmap <localleader>s :e %:r:r.stories.jsx<cr>
  au FileType javascript.jsx nmap <localleader>t :e %:r:r.spec.jsx<cr>
  au FileType javascript.jsx nmap <localleader>m :e %:r:r.jsx<cr>

  au FileType typescript setlocal foldmethod=syntax
  au FileType typescript setlocal iskeyword+=-
  au FileType typescript setlocal formatprg=prettier\ --parser\ typescript\ --stdin-filepath\ %
  au FileType typescript setlocal formatexpr= 	" reset Fixedgq from polyglot
  au FileType typescript nmap <localleader>t :e %:r:r.spec.ts<cr>
  au FileType typescript nmap <localleader>m :e %:r:r.ts<cr>

  au FileType typescript.tsx setlocal foldmethod=syntax
  au FileType typescript.tsx setlocal iskeyword+=-
  au FileType typescript.tsx setlocal foldlevel=3
  au FileType typescript.tsx nmap <localleader>s :e %:r:r.stories.tsx<cr>
  au FileType typescript.tsx nmap <localleader>t :e %:r:r.spec.tsx<cr>
  au FileType typescript.tsx nmap <localleader>m :e %:r:r.tsx<cr>
augroup END

" }}}
" misc {{{

augroup ft_misc
  au!

  au BufNewFile,BufRead *.zsh-theme setlocal filetype=zsh
  au BufNewFile,BufRead *.env.local setlocal filetype=sh
  au BufNewFile,BufRead *.md setlocal textwidth=80
  au BufNewFile,BufRead *.md setlocal fo+=t " auto wrap at text width

  au FileType vim nnoremap <buffer> <silent> gx :call <sid>plug_gx()<cr>
  au FileType vim setlocal iskeyword+=-
  au CursorHold * silent call CocActionAsync('highlight') " Highlight the symbol and its references when holding the cursor.
augroup END

" }}}
" }}}
" vim: set foldlevel=0
