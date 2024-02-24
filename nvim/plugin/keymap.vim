nnoremap _ <cmd>vnew %:h<cr>

nnoremap <esc> <cmd>nohlsearch<cr><cmd>pclose<cr><cmd>echo <cr>

" more undo stops in insert mode
inoremap ! !<c-g>u
inoremap . .<c-g>u
inoremap : :<c-g>u
inoremap ; ;<c-g>u
inoremap ? ?<c-g>u
inoremap , ,<c-g>u

cnoremap <expr> %%  getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" visual select last inserted text
nnoremap gV `[v`] 

" change inside|around all [wW]ords
" word Word
nnoremap ciaw viw*<esc>:%s///<left>
nnoremap ciaW viW*<esc>:%s///<left>
nnoremap caaw vaw*<esc>:%s///<left>
nnoremap caaW vaW*<esc>:%s///<left>

nnoremap <F12> <cmd>Ts<CR>i
tnoremap <F12> <C-\><C-n><cmd>T<CR>

" better terminal exits
tnoremap <c-[> <C-\><C-n>
tnoremap <Esc> <C-\><C-n>

" when moving more than 5 lines , then make a jump, to be able to revert via c-o
nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'gj'
nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'gk'

nnoremap <leader>dts mz:%s/ \+$//<cr>`z<cr>

nnoremap z0 zMzvzz

nnoremap  <C-d>zz
nnoremap  <C-u>zz

nnoremap <leader>M <cmd>Messages<cr>

nnoremap ]c <cmd>cn<cr>
nnoremap [c <cmd>cp<cr>
nnoremap ]l <cmd>lnext<cr>
nnoremap [l <cmd>lprev<cr>

" split a line in two, making the right above the left (usefull to move comments)
nnoremap X i<cr><esc>ddkP
" the inverse
nnoremap gX ddpkJ  

" buffer navigation
nnoremap gf <cmd>e <cfile><CR>
nnoremap <silent> <leader>x <cmd>b#\|bd#<cr>
nnoremap <silent> <leader>b0 <cmd>%bd\|e#<cr>

nnoremap <silent> <leader>n <cmd>cn<cr>
nnoremap <silent> <leader>p <cmd>cp<cr>

nnoremap <c-n> <cmd>bn<cr>
nnoremap <c-p> <cmd>bp<cr>

nnoremap <leader>it <cmd>TSHighlightCapturesUnderCursor<cr>

nnoremap <leader>tn <cmd>Num<cr>
nnoremap <leader>tg <cmd>Gitsigns toggle_signs<cr>
nnoremap <leader>tc <cmd>TSContextToggle<cr>

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

xnoremap ga         <Plug>(EasyAlign)
nnoremap ga         <Plug>(EasyAlign)

nnoremap <leader>tu <cmd>MundoToggle<CR>

nnoremap <M-s> :Format<cr>:w<cr>
nnoremap <D-s> :Format<cr>:w<cr>
inoremap <M-s> <cmd>Format<cr><cmd>w<cr>
inoremap <D-s> <cmd>Format<cr><cmd>w<cr>

nnoremap [[ gT
nnoremap ]] gt

nnoremap <c-f> mfgg=G`f<cmd>write<cr>
