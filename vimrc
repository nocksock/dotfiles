vim9script

# plugins {{{
if empty(glob('~/.vim/autoload/plug.vim'))
    silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-fugitive'
Plug 'honza/vim-snippets'
Plug 'SirVer/ultisnips'
Plug 'tpope/vim-surround'
Plug 'SirVer/ultisnips'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-eunuch'
Plug 'simnalamburt/vim-mundo'
Plug 'mattn/emmet-vim'
Plug 'rose-pine/vim'
Plug 'airblade/vim-gitgutter'
call plug#end()

colorscheme rosepine

# }}}
# keymap {{{
xnoremap ga <Plug>(EasyAlign)
nnoremap ga <Plug>(EasyAlign)

nnoremap <c-p> :Files<cr>
nnoremap <c-b> :Buffers<cr>

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

nnoremap <leader>tu :MundoToggle<cr>

# List
nnoremap <leader>l <cmd>ls<cr>:b<space>
nnoremap <leader>m <cmd>marks<cr>:normal<space>'
nnoremap <leader>r <cmd>registers<cr>:normal<space>"
nnoremap <leader>s :Lines <c-r><c-w><cr>

# Toggle Quickfix
nnoremap <silent> <leader>q :call util#ToggleQuickfix()<cr>

# Grep
nnoremap <leader>g :Grep <c-r><c-w><cr>
# Line highlight
nnoremap <silent> <leader>H <cmd>call matchadd('LineHighlight', '\%' .. line('.') .. 'l')<cr>
nnoremap <silent> <leader>C <cmd>call clearmatches()<cr>

# Quickfix last spelling error
inoremap <C-l> <C-g>u<Esc>[s1z=`]a<C-g>u

g:UltiSnipsExpandTrigger       = "<tab>"
g:UltiSnipsJumpForwardTrigger  = "<c-b>"
g:UltiSnipsJumpBackwardTrigger = "<c-z>"
#}}}
# status line {{{
set statusline=%{statusline#GitBranch()}
set statusline+=\ \ %<%f\ %h%m%r
set statusline+=%=
set statusline+=\ \ %P%{\'\ \'}
#}}}

