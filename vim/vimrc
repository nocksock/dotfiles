vim9script

# plugins {{{
packadd matchit
packadd cfilter

import autoload 'pack.vim'
import autoload 'statusline.vim'
import autoload 'completion.vim'

command! PackUpdate pack.Init() | minpac#update()
command! PackClean  pack.Init() | minpac#clean()
command! PackStatus pack.Init() | minpac#status()

# }}}
# settings {{{
syntax enable
filetype plugin indent on

g:mapleader = " "
set noerrorbells
set textwidth=100
set scrolloff=3
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
set undodir=~/.vim/undo-history

# tabs / indent / spaces
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent
set expandtab
set smarttab
set cindent

# basic completion
set complete+=k,b,i
set completeopt=menuone,noinsert,preview

# Reduce noise
set shortmess+=cCsmnrf

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
set display+=truncate

# Grep
set grepprg=rg\ --vimgrep
set grepformat=%f:%l:%c:%m

# Wrapping
set breakindent
set briopt=shift:4
set linebreak
set wrap

g:lsp_log_file = expand('~/vim-lsp.log')
g:lsp_show_message_log_level = 'none'
g:lsp_diagnostics_signs_delay = 250
g:lsp_diagnostics_echo_cursor = 1
g:lsp_diagnostics_virtual_text_enabled = 0
g:lsp_diagnostics_signs_error = {'text': ''}
g:lsp_diagnostics_signs_warning = {'text': ''}
g:lsp_diagnostics_signs_information = {'text': '󰋽'}
g:lsp_diagnostics_signs_hint = {'text': '‼'}
g:lsp_document_code_action_signs_hint = {'text': '󰻷'}
g:lsp_format_sync_timeout = 1000
g:lsp_use_native_client = 1
g:lsp_diagnostics_virtual_text_enabled = 1
g:lsp_diagnostics_virtual_text_align = "after"

# }}}
# plugin settings {{{
g:netrw_altfile = 1
g:netrw_banner = 0
g:netrw_winsize = 33

# align \, which I often use in bash scripts etc.
g:easy_align_delimiters = { '\\': { pattern: '\',  left_margin: 1, right_margin: 0 } }

g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit',
  \ 'ctrl-q': 'fill_quickfix'}

# }}}
# colors {{{
set termguicolors
colorscheme lunaperche
set bg=dark

hi LineHighlight guibg=#106060 guifg=NONE gui=None cterm=bold
# }}}

# Key map {{{
xnoremap ga <Plug>(EasyAlign)
nnoremap ga <Plug>(EasyAlign)

nnoremap <leader>f :Files<cr>
nnoremap <leader><leader> :Buffers<cr>
nnoremap <leader>C :Colors<cr>
nnoremap <leader>/ :RG<cr>

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap <silent> <Up> <cmd>resize -4<cr>
nnoremap <silent> <Down> <cmd>resize +4<cr>
nnoremap <silent> <Left> <cmd>vertical resize -4<cr>
nnoremap <silent> <Right> <cmd>vertical resize +4<cr>
nnoremap <silent> <S-Up> <cmd>resize -12<cr>
nnoremap <silent> <S-Down> <cmd>resize +12<cr>
nnoremap <silent> <S-Left> <cmd>vertical resize -12<cr>
nnoremap <silent> <S-Right> <cmd>vertical resize +12<cr>

# More undo stops in insert mode
imap ! !<c-g>u
imap . .<c-g>u
imap : :<c-g>u
imap ; ;<c-g>u
imap ? ?<c-g>u
imap , ,<c-g>u

# List
nnoremap <leader>l <cmd>ls<cr>:b<space>
nnoremap <leader>m <cmd>marks<cr>:normal<space>'
nnoremap <leader>r <cmd>registers<cr>:normal<space>"
nnoremap <leader>s :Lines<cr>

# Toggle Quickfix
nnoremap <silent> <leader>q :call util#ToggleQuickfix()<cr>

# Grep
nnoremap <leader>g :Grep <c-r><c-w><cr>

# Line highlight
nnoremap <silent> <leader>H <cmd>call matchadd('LineHighlight', '\%' .. line('.') .. 'l')<cr>
nnoremap <silent> <leader>C <cmd>call clearmatches()<cr>

# split a line in two, making the right above the left (usefull to move comments)
nnoremap X i<cr><esc>ddkP

# Quickfix last spelling error
inoremap <C-h> <C-g>u<Esc>[s1z=`]a<C-g>u

# Better terminal exits
tnoremap <c-[> <C-\><C-n>
tnoremap <Esc> <C-\><C-n>

# Visual select last inserted text
nnoremap gV `[v`]

# Remove trailing spaces
nnoremap <leader>dts mz:%s/ \+$//<cr>`z<cr>

# Misc shortcuts
nnoremap <leader>tu :MundoToggle<cr>
nnoremap <c-w>- :vnew .<cr>

# # autocompletion
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <c-space> <c-x><c-o>

nnoremap ciaw viw*<esc>:%s///<left>
nnoremap ciaW viW*<esc>:%s///<left>
nnoremap caaw vaw*<esc>:%s///<left>
nnoremap caaW vaW*<esc>:%s///<left>

# split a line in two, making the right above the left (usefull to move comments)
nnoremap X i<cr><esc>ddkP
# the inverse:
nnoremap gX ddpkJ  

# buffer navigation
nnoremap gf <cmd>e <cfile><CR>
nnoremap <silent> <tab> <cmd>bn<cr> 
nnoremap <silent> <s-tab> <cmd>bp<cr>
nnoremap <silent> <leader>x <cmd>b#\|bd#<cr>

nnoremap <silent> <leader>b0 <cmd>%bd\|e#<cr>
nnoremap <silent> <leader>bd <cmd>bd<cr>

nnoremap <c-n> <cmd>cn<cr>
nnoremap <c-p> <cmd>cp<cr>

nnoremap <leader>Sl <cmd>call UltiSnips#ListSnippets()<cr>
nnoremap <leader>Se <cmd>UltiSnipsEdit<cr>

nnoremap <leader>cc <cmd>Git commit<cr>
nnoremap <leader>hs <cmd>GitGutterStageHunk<cr>
nnoremap <leader>hr <cmd>GitGutterRevertHunk<cr>

g:UltiSnipsExpandTrigger       = "<tab>"
g:UltiSnipsJumpForwardTrigger  = "<c-j>"
g:UltiSnipsJumpBackwardTrigger = "<c-h>"

#}}}
# status line {{{

set statusline=%{statusline#GitBranch()}
set statusline+=\ %<%f%h%m%r
set statusline+=%w
set statusline+=%=
set statusline+=%{&filetype!=''?&filetype:&syntax}

#}}}
# lsp configs {{{
# typescript {{{
var tsserver = {
    'name': 'typescript-language-server',
    'cmd': (server_info) => [&shell, &shellcmdflag, 'typescript-language-server --stdio'],
    'root_uri': (server_info) => lsp#utils#path_to_uri(
        lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'tsconfig.json')
    ),
    'whitelist': ['typescript', 'typescript.tsx', 'typescriptreact'] }

var rust_analyzer = {
    'name': 'rust-analyzer',
    'cmd': (server_info) => [&shell, &shellcmdflag, 'rust-analyzer'],
    'root_uri': (server_info) => lsp#utils#path_to_uri(
        lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'Cargo.toml')
    ),
    'whitelist': ['rust'] }

augroup lsp_install
    au!
    au User lsp_setup call lsp#register_server(tsserver)
    au User lsp_setup call lsp#register_server(rust_analyzer)
    au User lsp_buffer_enabled call g:snock#LspBindings()
augroup END
# }}}
# }}}
# commands {{{
# Grep
command! -nargs=+ Grep  execute 'silent grep! <args>' | copen | wincmd p | redraw!

# Completion
command! ComplEnable  completion.Enable()
command! ComplDisable completion.Disable()

# }}}
