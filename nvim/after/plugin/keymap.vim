nnoremap _ <cmd>vnew %<cmd>h<cr>

nnoremap <silent> <esc> <cmd>nohlsearch<cr><cmd>pclose<cr>

" more undo stops in insert mode
inoremap ! !<c-g>u
inoremap . .<c-g>u
inoremap : :<c-g>u
inoremap ; ;<c-g>u
inoremap ? ?<c-g>u
inoremap , ,<c-g>u

inoremap ,, <esc>A,
inoremap ;; <esc>A;

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

nnoremap <leader>gcc <cmd>normal yygccp<cr>
nnoremap <leader>gcip <cmd>normal "cyipgcip)"cP<cr>
nnoremap <leader>gcap <cmd>normal "cyapgcap)"cP<cr>

nnoremap <leader>M <cmd>Messages<cr>

nnoremap ]c <cmd>cn<cr>
nnoremap [c <cmd>cp<cr>
nnoremap ]l <cmd>lnext<cr>
nnoremap [l <cmd>lprev<cr>

" split a line in two, making the right above the left (usefull to move comments)
nnoremap X i<cr><esc>ddkP
nnoremap gX ddpkJ  " the inverse

nnoremap <leader>cc <cmd>Git commit<cr>

" buffer navigation
nnoremap gf <cmd>e <cfile><CR>
nnoremap <silent> <tab> <cmd>bn<cr> 
nnoremap <silent> <s-tab> <cmd>bp<cr>
nnoremap <silent> <leader>x <cmd>b#\|bd#<cr>

nnoremap <silent> <leader>b0 <cmd>%bd\|e#<cr>
nnoremap <silent> <leader>bd <cmd>bd<cr>

nnoremap <c-n> <cmd>cn<cr>
nnoremap <c-p> <cmd>cp<cr>

" <c-;> to quickly go to a previous command
nnoremap <c-;> <cmd><c-p>
cnoremap <c-;> <c-p>

nnoremap <leader>it <cmd>TSHighlightCapturesUnderCursor<cr>
nnoremap <silent> <leader>ttl <cmd>execute "set showtabline=" . (&showtabline == 0 ? 2 <cmd> 0)<CR>

nnoremap <leader>tn <cmd>Num<cr>
nnoremap <leader>tg <cmd>Gitsigns toggle_signs<cr>
nnoremap <leader>td <cmd>DoToggle<cr>

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nmap <leader>" :lua require('rucksack').show()<cr>
nmap <leader>y :lua require('rucksack').stash()<cr>
vmap <leader>y :lua require('rucksack').stash()<cr>

nmap <leader>f <cmd>Telescope find_files<cr>
nmap <leader>F <cmd>Telescope find_files hidden=true cwd=%:p:h<cr>
nmap <leader>* <cmd>Telescope grep_string<cr>
nmap <leader>/ <cmd>Telescope live_grep<cr>
nmap <leader>? <cmd>Telescope live_grep cwd=%:p:h<cr>
nmap <leader>: <cmd>Telescope commands<cr>
nmap <leader>; <cmd>Telescope command_history<cr>
nmap <leader><cr> <cmd>Telescope resume<cr>
nmap <leader>h <cmd>Telescope help_tags<cr>
nmap <leader>S <cmd>Telescope lsp_dynamic_workspace_symbols<cr>
nmap <leader><leader> <cmd>Telescope buffers<cr>
nmap <leader>s <cmd>Telescope lsp_document_symbols<cr>
nmap <leader>C <cmd>Telescope colorscheme enable_preview=true<cr>
nmap <leader>T <cmd>Telescope builtin<cr>
nmap <leader>l <cmd>Telescope current_buffer_fuzzy_find<cr>

" { 'ga', '<Plug>(EasyAlign)', mode = "x" },
" { 'ga', '<Plug>(EasyAlign)' },

" { '<leader>m', ':lua require("treesj").toggle()<cr>' }

" { '<leader>tu', '<cmd>MundoToggle<CR>' }
"
"       { '[h',         "<cmd>Gitsigns prev_hunk<CR>" },
 "     { ']h',         "<cmd>Gitsigns next_hunk<CR>" },
 "     { '<leader>hs', function() require("gitsigns.actions").stage_hunk() end, },
 "     { '<leader>hs', function() require("gitsigns.actions").stage_hunk() end, },
 "     { '<leader>hr', function() require("gitsigns.actions").reset_hunk() end, },
 "     { '<leader>hr', function() require("gitsigns.actions").reset_hunk() end, },
 "     { '<leader>hu', function() require("gitsigns.actions").undo_stage_hunk() end, },
 "     { '<leader>hS', function() require("gitsigns.actions").stage_buffer() end, },
 "     { '<leader>hR', function() require("gitsigns.actions").reset_buffer() end, },
 "     { '<leader>hp', function() require("gitsigns.actions").preview_hunk() end, },
 "     { '<leader>hb', '<cmd>lua require"gitsigns".blame_line{full=true}<CR>', },
 "     { '<leader>hd', function() require("gitsigns.actions").diffthis() end, },
 "     { '<leader>hD', function() require "gitsigns".diffthis("~") end, },
 "     {
 "       'ic',
 "       function() require("gitsigns.actions").select_hunk() end,
 "       mode = "o",
 "     },
 "     {
 "       'ic',
 "       function() require("gitsigns.actions").select_hunk() end,
 "       mode = "x",
 "     },
 "
" { "<leader>'",  '<cmd>lua require("harpoon.mark").add_file()<CR>' },
" { "''",         ':lua require("harpoon.ui").toggle_quick_menu()<CR>' },
" { "<leader>;;", '<cmd>lua lua require("harpoon.cmd-ui").toggle_quick_menu()<cr>' },
" { "<leader>;f", '<cmd>lua require("harpoon.term").gotoTerminal(1)<cr>' },
" { "'f",         '<cmd>lua require("harpoon.ui").nav_file(1)<CR>' }, -- alt + j
" { "'d",         '<cmd>lua require("harpoon.ui").nav_file(2)<CR>' }, -- alt + k
" { "'s",         '<cmd>lua require("harpoon.ui").nav_file(3)<CR>' }, -- alt + l
" { "'a",         '<cmd>lua require("harpoon.ui").nav_file(4)<CR>' }, -- alt + ;
