"
" Hi!
"
"   This is my messy but *also* large .vimrc
"
" Author: Nils Riedemann
" Website: https://bleepbloop.studio/
" Repository: https://github.com/nocksock/dotfiles
" Email: nils@bleepbloop.studio
"
" ==============================================================================

lua require('snock.plugins')
lua require('snock.lsp')
lua require('snock.telescope')
lua require('snock.statusline')

" #set basic options {{{
let mapleader = "\<space>"
let maplocalleader = "\<c-@>"   " use ctrl-space as local leader

set autoindent                                           " Copy indent from current line when creating a new line                                            "
set autoread                                             " auto re-read file when it changed outside of vim, but not inside
set backspace=indent,eol,start                           " allow backspacing over everything in insert mode
set backup                                               " enable backups
set backupdir=/tmp
set backupdir=~/.config/nvim/tmp/backup/                         " backups
set backupskip=/tmp/*,/private/tmp/*                     " Make Vim able to edit crontab files again.
set breakindent                                          " wrapped lines appear indendet
set clipboard=unnamed
set encoding=utf-8
set expandtab                                            " use spaces for indentation by default
set foldenable
set foldmethod=marker  " use markers (tripple curly braces unless changed) for folding
set foldnestmax=10
set formatoptions=qrn1j " format options when writing, joining lines or `gq` see  :he fo-table for meanings
set gdefault                                             " add g flag by default for :substitutions
set hidden                                               " enable hidden buffers - so i can switch buffers even if current is changed.
set history=10000 " keep way more commands in history
set hlsearch " highlight search results
set incsearch                                            " enable incremental search that would make vim jump around while typing
set ignorecase " ignore case by default - unless using uppercase/lowercase via smartcase
set laststatus=2                                         " Always show status line.
set list                                                 " Show invisible characters
set listchars=tab:\|⋅,eol:¬,trail:-,extends:↩,precedes:↪ " define characters for invisible characters
set mouse=a                                              " enable scrolling and selecting with mouse
set cursorline                                         " Highlight the line of in which the cursor is present (or not)
set noshowmode                                           " Don't show mode (insert, visual etc) on the last line. Is handled by lightline
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
set t_Co=256                                             " term colors
set t_ut=
set tabstop=2
set termguicolors                                        " enable 24bit colors
set textwidth=80
set undodir=~/.config/nvim/tmp/undo/
set t_8b=[48;2;%lu;%lu;%lum " sometimes setting termguicolors for true color support  is not enough see
set t_8f=[38;2;%lu;%lu;%lum " :he t_8b
set undofile
set wildmenu
set wildignore+=*.DS_Store                               " ignore OSX bullshit
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg           " ignore binary images
set wildignore+=**/coverage/*
set wildignore+=**/node_modules/*
set wildignore+=**/android/*
set wildignore+=**/.git/*
set wildmode=longest,list,full
set guifont=JetBrains\ Mono:h15

let g:netrw_altfile=1 " make CTRL-^ ignore netrw buffers
let g:markdown_folding = 1 " enable headline folding in markdown files

syntax on
colorscheme bloop_nvim

" use different undo directory for vim/nvim since they're not compatible

" }}}
" plugin configs {{{

let g:UltiSnipsExpandTrigger="<c-l>"
let g:UltiSnipsJumpForwardTrigger="<c-l>"
let g:UltiSnipsJumpBackwardTrigger="<c-h>"
let g:UltiSnipsSnippetStorageDirectoryForUltiSnipsEdit="~/personal/ulti-snippets"

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

let g:lightline = {
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

" }}}

" reload lightline entirely - useful when changing its configuration
command! LightLineReload
      \ call lightline#init()
      \ call lightline#colorscheme()
      \ call lightline#update()

command! GG :tab G
" 
" mappings, motions and textobjects {{{

nmap gx :execute '!open ' . shellescape(expand('<cWORD>'), 1)<cr>

nmap [t :tabprevious<cr>
nmap ]t :tabnext<cr>
nmap [T :tabfirst<cr>
nmap ]T :tablast<cr>
nmap [b :bprevious<cr>
nmap ]b :bnext<cr>
nmap [B :bfirst<cr>
nmap ]B :blast<cr>

nnoremap <leader><leader> <cmd>Telescope find_files theme=dropdown<cr>
nnoremap <leader>;     <cmd>terminal ++rows=15<cr>
nnoremap <leader>X     <cmd>ped ~/notes/x<cr>
nnoremap <leader>x     <cmd>ped .notes.md<cr>
nnoremap <leader>b     <cmd>Telescope buffers theme=dropdown<cr>
nnoremap <leader>/     <cmd>Telescope live_grep theme=dropdown<cr>
nnoremap <leader>h     <cmd>Telescope help_tags<cr>
nnoremap <leader>r     <cmd>Telescope oldfiles<cr>

nmap <leader>dts mz:%s/ \+$//<cr>`z<cr> | " delete trailing spaces
nmap <leader>ci :call CocAction('runCommand', 'editor.action.organizeImport')<cr>

" vscode-likes (close to vscode bindings for presentations)
nmap <c-s> :w<cr>
nmap <leader>ki <Plug>:LspDiagLine
nmap <leader>.  <cmd>Telescope lsp_code_actions<cr>
nmap <F2> <Plug>(coc-rename)

nmap <silent> K :call <SID>show_documentation()<CR> " Use K to show documentation in preview popup.
inoremap ;; <Esc>m`A;<esc>``i " Easy insertion of a trailing ; from insert mode
inoremap ,, <Esc>m`A,<esc>``i " Easy insertion of a trailing , from insert mode

cmap <expr> %%  getcmdtype() == ':' ? expand('%:h').'/' : '%%' " type %% in vim's prompt to insert %:h expanded

nmap n nzzzv " Keep search matches in the middle of the window
nmap N Nzzzv

nmap gV `[v`]   " visual select last inserted text

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
" }}}
" file type specifcs #ft {{{
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
" misc {{{

augroup ft_misc
  au!

  au BufNewFile,BufRead *.zsh-theme setlocal filetype=zsh
  au BufNewFile,BufRead *.env.local setlocal filetype=sh

  au BufNewFile,BufRead *.md setlocal textwidth=80
  au BufNewFile,BufRead *.md setlocal fo+=t " auto wrap at text width

  au FileType vim nnoremap <buffer> <silent> gx :call <sid>plug_gx()<cr>
  au FileType vim setlocal iskeyword+=-
  au FileType vim nmap <F2> :execute getline(".")<cr>
  au FileType vim vnoremap <F2> :<c-u>exe join(getline("'<","'>"),'<bar>')<cr>

  au FileType json set foldmethod=syntax

  au FileType php let b:AutoPairs = AutoPairsDefine({'<?' : '?>', '<?php': '?>'})
  au FileType html let b:AutoPairs = AutoPairsDefine({'<!--' : '-->'})

  " au CursorHold * silent call CocActionAsync('highlight') " Highlight the symbol and its references when holding the cursor.
augroup END

" }}}
" }}}
" config #meta {{{

" When saving a buffer, create directories if they do not yet exist.
augroup Mkdir
  autocmd!
  autocmd BufWritePre * call mkdir(expand("<afile>:p:h"), "p")
augroup END

" }}}

" vim:fen fdm=marker fmr={{{,}}} fdl=0 ft=vim
