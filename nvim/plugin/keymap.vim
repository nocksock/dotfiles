" better escape
nnoremap <esc> <cmd>nohlsearch<cr><cmd>pclose<cr><cmd>echo <cr>

" undo stops in insert mode. `u` will halt at these points
inoremap ! !<c-g>u
inoremap . .<c-g>u
inoremap : :<c-g>u
inoremap ; ;<c-g>u
inoremap ? ?<c-g>u
inoremap , ,<c-g>u

" typing %% in cmd to insert path to buffer's parent
cnoremap <expr> %%  getcmdtype() == ':' ? expand('%:h').'/' : '%%'
cnoremap <expr> tt  getcmdtype() == ':' ? "terminal " : 'tt'

" copy current file name relative to cwd to clipboard
nnoremap <leader>yf <cmd>let @+ = expand('%:.')<cr>

" visual select last inserted text
nnoremap gV `[v`] 

" change inside|around all [wW]ords
nnoremap ciaw viw*<esc>:%s///<left>
nnoremap ciaW viW*<esc>:%s///<left>
nnoremap caaw vaw*<esc>:%s///<left>
nnoremap caaW vaW*<esc>:%s///<left>

" when moving more than 5 lines , then make a jump, to be able to revert via c-o
nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'gj'
nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'gk'

" delete trailing whitespaces in doc
nnoremap <leader>dts mz:%s/ \+$//<cr>`z<cr>

nnoremap ]c <cmd>cn<cr>
nnoremap [c <cmd>cp<cr>
nnoremap ]l <cmd>lnext<cr>
nnoremap [l <cmd>lprev<cr>

" split a line in two, making the right above the left (usefull to move comments)
nnoremap X i<cr><esc>ddkP
" the inverse
nnoremap gX ddpkJ  

" buffer navigation
nnoremap <silent> <leader>X <cmd>b#\|bd#<cr>
nnoremap <silent> <leader>x <cmd>bd<cr>
nnoremap <silent> <leader>b0 <cmd>%bd\|e#<cr>

nnoremap <silent> <leader>n <cmd>cn<cr>
nnoremap <silent> <leader>p <cmd>cp<cr>
nnoremap <c-n> <cmd>bn<cr>
nnoremap <c-p> <cmd>bp<cr>

" show treesitter highlight groups for word under cursor
nnoremap <leader>it <cmd>TSHighlightCapturesUnderCursor<cr>

" toggles
nnoremap <leader>tn <cmd>Num<cr>
nnoremap <leader>tg <cmd>Gitsigns toggle_signs<cr>
nnoremap <leader>tsc <cmd>TSContextToggle<cr>
nnoremap <leader>tu <cmd>MundoToggle<CR>
nnoremap <leader>tdb :DBUIToggle<cr>
nnoremap <leader>do :DoToggle<cr>
nnoremap <leader>de :DoEdit<cr>
nnoremap <leader>tch <Cmd>CodeCompanionChat Toggle<CR>

" faster window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

xnoremap ga <Plug>(EasyAlign)
nnoremap ga <Plug>(EasyAlign)

" Use cmd+s to save and format
nnoremap <M-s> :Format<cr>:w<cr>
nnoremap <D-s> :Format<cr>:w<cr>
inoremap <M-s> <cmd>Format<cr><cmd>w<cr>
inoremap <D-s> <cmd>Format<cr><cmd>w<cr>

" open oil at cwd
nnoremap + :Oil .<cr>
nnoremap _ <cmd>vnew %:h<cr>

" navigate between folds
nnoremap zj zjzt
nnoremap zk zkzkzjzt

nnoremap z0 zMzvzz
nnoremap  <C-d>zz
nnoremap  <C-u>zz
