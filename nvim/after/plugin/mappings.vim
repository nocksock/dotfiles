nnoremap _ :vnew .<cr>

nmap <esc> :nohlsearch<cr>:pclose<cr><c-l>
nmap <c-f> z

" more undo stops in insert mode
imap ! !<c-g>u
imap . .<c-g>u
imap : :<c-g>u
imap ; ;<c-g>u
imap ? ?<c-g>u
imap , ,<c-g>u

cnoreabb wd w\|:bd
cnoremap <expr> %%  getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" move lines up and down
vmap <c-k> :m '<-2<CR>gv=gv
vmap <c-j> :m '>+1<CR>gv=gv

" visual select last inserted text
nmap gV `[v`] 

nmap <F12> :Ts<CR>i
tmap <F12> <C-\><C-n>:T<CR>

" better terminal exits
tmap <c-[> <C-\><C-n>
tmap <Esc> <C-\><C-n>

" when moving more than 5 lines , then make a jump, to be able to revert via c-o
nmap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'gj'
nmap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'gk'

nmap <leader>dts mz:%s/ \+$//<cr>`z<cr>

map('n', 'z0', 'zMzvzz')
nmap z0 zMzvzz
nmap ì zMzvzz

nmap  <C-d>zz
nmap  <C-u>zz

nmap <leader>gc :normal yygccp<cr>
nmap <leader>gC :normal yipgcipP<cr>

nmap <leader>M :Messages<cr>

nmap ]c :cn<cr>
nmap [c :cp<cr>
nmap ]l :lnext<cr>
nmap [l :lprev<cr>

nmap <c-f> :RG<cr>
