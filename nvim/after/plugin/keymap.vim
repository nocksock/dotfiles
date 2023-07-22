nnoremap _ :vnew %:h<cr>

nnoremap <silent> <esc> :nohlsearch<cr>:pclose<cr><c-l>

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

nnoremap <leader>ciw :%s/\<<c-r><c-w>\>//g<left><left>
nnoremap <leader>caw "/yaw:%s///g<left><left>
nnoremap <leader>caW "/yaW:%s///g<left><left>
nnoremap <leader># #``

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

nnoremap  <C-d>zz
nnoremap  <C-u>zz

nnoremap <leader>gcc :normal yygccp<cr>
nnoremap <leader>gcip :normal "cyipgcip)"cP<cr>
nnoremap <leader>gcap :normal "cyapgcap)"cP<cr>

nnoremap <leader>M :Messages<cr>

nnoremap ]c :cn<cr>
nnoremap [c :cp<cr>
nnoremap ]l :lnext<cr>
nnoremap [l :lprev<cr>

" split a line in two, making the right above the left (usefull to move comments)
nnoremap X i<cr><esc>ddkP
nnoremap gX ddpkJ  " the inverse

nnoremap <leader>sns :call UltiSnips#ListSnippets()<cr>
nnoremap <leader>sne :UltiSnipsEdit<cr>

nnoremap <leader>cc :Git commit<cr>
nnoremap g. `^

nnoremap <cr> i<cr><esc>
nnoremap <silent> <tab> :bn<cr> 

" buffer navigation
nnoremap <silent> <s-tab> :bp<cr>
nnoremap <silent> <leader>X :b#\|bd#<cr>
nnoremap <silent> <leader>x :bd<cr>
nnoremap <silent> <leader>b0 :%bd\|e#<cr>

cnoreabb b0 %bd\|e#
cnoreabb b0! %bd!\|e#
cnoreabb wd w\|:bd

nnoremap <c-n> :cn<cr>
nnoremap <c-p> :cp<cr>
nnoremap <c-;> :<c-p>
cnoremap <c-;> <c-p>

nnoremap <leader>it :TSHighlightCapturesUnderCursor<cr>
nnoremap <silent> <leader>ttl :execute "set showtabline=" . (&showtabline == 0 ? 2 : 0)<CR>

