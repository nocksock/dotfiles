nnoremap _ :vnew .<cr>

nnoremap <esc> :nohlsearch<cr>:pclose<cr><c-l>

" more undo stops in insert mode
inoremap ! !<c-g>u
inoremap . .<c-g>u
inoremap : :<c-g>u
inoremap ; ;<c-g>u
inoremap ? ?<c-g>u
inoremap , ,<c-g>u

cnoreabb wd w\|:bd
cnoremap <expr> %%  getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" visual select last inserted text
nnoremap gV `[v`] 

nnoremap <F12> :Ts<CR>i
tnoremap <F12> <C-\><C-n>:T<CR>

" better terminal exits
tnoremap <c-[> <C-\><C-n>
tnoremap <Esc> <C-\><C-n>

" when moving more than 5 lines , then make a jump, to be able to revert via c-o
nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'gj'
nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'gk'

nnoremap <leader>dts mz:%s/ \+$//<cr>`z<cr>

nnoremap z0 zMzvzz
nnoremap ì zMzvzz

nnoremap  <C-d>zz
nnoremap  <C-u>zz

nnoremap <leader>gc :normal yygccp<cr>
nnoremap <leader>gC :normal yipgcipP<cr>

nnoremap <leader>M :Messages<cr>

nnoremap ]c :cn<cr>
nnoremap [c :cp<cr>
nnoremap ]l :lnext<cr>
nnoremap [l :lprev<cr>

" split a in two, making the right above the left (usefull to move comments)
nnoremap X i<cr><esc>ddkP
