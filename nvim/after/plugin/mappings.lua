local function map(mode, key, command, opts)
  opts = vim.tbl_extend('force', { noremap = true, silent = true }, opts or {})
  vim.keymap.set(mode, key, command, opts)
end

-- Prefixes for description {{{
-- also used to create a coherent mapping system
local prefix = function(s)
  return function(suffix)
    return { desc = s .. " " .. suffix }
  end
end

local b = prefix "[b]uffer"
local d = prefix "[d]ebug"
local h = prefix "[h]unk"
local s = prefix "[s]earch"
local t = prefix "[t]oggle"
local x = prefix "[x] globals"

--}}}
-- Telescope and file finding {{{
map('n', '<leader><space>', ":Telescope buffers<cr>", { desc = '[ ] Find existing buffers' })
map('n', '<leader><cr>', ":Telescope resume<cr>", { desc = '[] resume previous search' })
map('n', '<leader>T', ":Telescope builtin<cr>", { desc = 'builtin [T]elescope commands' })
map('n', '<leader>/', ':Telescop current_buffer_fuzzy_find<cr>', { desc = '[/] Fuzzily search in current buffer' })
map('n', '<C-P>', ":Telescope find_files hidden=true<cr>", s('[f]iles'))
map('n', '<C-B>', ":Telescope buffers<cr>", { desc = '[ ] Find existing buffers' })
map('n', '<M-C-P>', ":Telescope commands<cr>", s('[c]ommands'))

map('n', '<M-p>', ":Telescope find_files<cr>", s('[f]iles'))
map('n', '<leader>sC', ":Telescop colorscheme enable_preview=true<cr>", s("[C]olors"))
map('n', '<leader>-', ":Telescope file_browser path=%:p:h<cr>", s('[f]iles'))
map('n', '<leader>sr', ":Telescope oldfiles<cr>", s('[r]ecently opened files'))
map('n', '<leader>sh', ":Telescop help_tags<cr>", s('[h]elp'))
map('n', '<leader>sc', ":Telescop commands<cr>", s('[c]ommands'))
map('n', '<leader>*', ":Telescop grep_string<cr>", s('current [w]ord'))
map('n', '<leader>gb', ":Telescop git_branches<cr>", {desc = '[g]it [b]ranches'})
map('n', '<leader>gs', ':Telescope git_status<cr>', { desc = '[g]it [s]tatus' })

map('n', '<leader>sg', ":lua require('telescope').extensions.live_grep_args.live_grep_args()<cr>", s('by [g]rep'))
map('n', '<leader>sp', ":lua R('snock.plugins.search-plugins').search()<cr>", s('[p]lugins'))
--}}}
-- Buffer {{{
map('n', '<leader>bd', ':b#|bd#<cr>', b("[D]elete    , keep layout"))
map('n', '<leader>bD', ':bd', b("[D]elete"))
map('n', '<leader>bO', ':%bd|e#<cr>', b("[O]nly"))
map('n', '<leader>1', ':LualineBuffersJump 1<cr>')
map('n', '<leader>2', ':LualineBuffersJump 2<cr>')
map('n', '<leader>3', ':LualineBuffersJump 3<cr>')
map('n', '<leader>4', ':LualineBuffersJump 4<cr>')
map('n', '<leader>5', ':LualineBuffersJump 5<cr>')
map('n', '<leader>6', ':LualineBuffersJump 6<cr>')
map('n', '<leader>7', ':LualineBuffersJump 7<cr>')
map('n', '<leader>8', ':LualineBuffersJump 8<cr>')
map('n', '<leader>9', ':LualineBuffersJump 9<cr>')
--}}}
-- Terminal {{{
map('n', '<F12>', ':Ts<CR>i')
map('t', '<F12>', [[<C-\><C-n>:T<CR>]])

-- better terminal exits
map('t', '<c-[>', '<C-\\><C-n>')
map('t', '<Esc>', '<C-\\><C-n>')
-- }}}
-- Debugging{{{
map('n', '<leader>db', ':DapToggleBreakpoint<cr>', d('toggle [b]reakpoint'))
map('n', '<leader>du', ':lua require("dapui").toggle()<cr>', d("toggle [u]i"))
map('n', '<leader>dc', ':DapContinue<cr>', d("[c]ontinue"))
map('n', '<leader>di', ':DapStepInto<cr>', d("step [i]nto"))
map('n', '<leader>do', ':DapStepOver<cr>', d("step [o]ver"))
map('n', '<leader>dO', ':DapStepOut<cr>', d("step [O]ut"))
map('n', '<leader>dl', ':DapRunLast<cr>', d("Run [l]ast"))
--}}}
-- Diagnostics {{{
map('n', '<leader>xd', ':Trouble document_diagnostics<CR>', x "show [d]ocument_diagnostics")
map('n', '<leader>xD', ':Trouble workspace_diagnostics<CR>', x "show workspace_[D]iagnostics")
map('n', '<leader>xt', ':TodoTrouble<CR>', x "[t]odos")
map('n', '<leader>k', vim.diagnostic.goto_prev)
map('n', '<leader>j', vim.diagnostic.goto_next)
map('n', '<leader>e', vim.diagnostic.open_float)
map('n', '<leader>q', vim.diagnostic.setloclist)
map('n', "<leader>K", function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR }) end)
map('n', "<leader>J", function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR }) end)
-- }}}

-- Harpoon {{{
-- file nav
map('n', "<leader>'", ':lua require("harpoon.mark").add_file()<CR>')
map('n', "<c-h>", ':lua require("harpoon.ui").toggle_quick_menu()<CR>')

map('n', "'f", ':lua require("harpoon.ui").nav_file(1)<CR>') -- alt + j
map('n', "'d", ':lua require("harpoon.ui").nav_file(2)<CR>') -- alt + k
map('n', "'s", ':lua require("harpoon.ui").nav_file(3)<CR>') -- alt + l
map('n', "'a", ':lua require("harpoon.ui").nav_file(4)<CR>') -- alt + ;

--}}}
-- Git hunk handling {{{
local gitsigns = require('gitsigns.actions')
map('n', '<leader>gg', ':tab G<cr>')
map('n', '<leader>cc', ':Git commit<cr>')
map('n', ']h', "<cmd>Gitsigns next_hunk<CR>")
map('n', '[h', "<cmd>Gitsigns prev_hunk<CR>")
map('n', '<leader>hs', gitsigns.stage_hunk, h '[s]tage')
map('v', '<leader>hs', gitsigns.stage_hunk, h '[s]tage')
map('n', '<leader>hr', gitsigns.reset_hunk, h '[r]eset')
map('v', '<leader>hr', gitsigns.reset_hunk, h '[r]eset')
map('n', '<leader>hu', gitsigns.undo_stage_hunk, h '[U]ndo stage')
map('n', '<leader>hS', gitsigns.stage_buffer, h '[S]tage buffer')
map('n', '<leader>hR', gitsigns.reset_buffer, h '[R]eset buffer')
map('n', '<leader>hp', gitsigns.preview_hunk)
map('n', '<leader>hb', ':lua require"gitsigns".blame_line{full=true}<CR>')
map('n', '<leader>hd', gitsigns.diffthis)
map('n', '<leader>hD', ':lua require"gitsigns".diffthis("~")<CR>')
map('o', 'ih', gitsigns.select_hunk)
map('x', 'ih', gitsigns.select_hunk)
-- }}}
-- Toggles {{{
map('n', '<M-b>', ':lua require("nvim-tree.api").tree.toggle()<CR>', { desc = "[t]ree [t]oggle" })
map('n', '<leader>tt', ':lua require("nvim-tree.api").tree.toggle()<CR>', { desc = "[t]ree [t]oggle" })
map('n', '<leader>tu', ':MundoToggle<CR>', { desc = "[t]oggle [u]ndo tree" })
map('n', '<leader>to', ':SymbolsOutline<cr>', { desc = "[t]oggle [o]utline" })
--}}}
-- Misc convenience {{{
-- more undo stops in insert mode {{{
map('i', '!', '!<c-g>u')
map('i', '.', '.<c-g>u')
map('i', ':', ':<c-g>u')
map('i', ';', ';<c-g>u')
map('i', '?', '?<c-g>u')
map('i', ',', ',<c-g>u')
--}}}
-- infos {{{
map('n', '<leader>it', ':TSHighlightCapturesUnderCursor<cr>')
map('n', '<leader>id', '<Plug>:LspDiagLine<cr>')
map('n', '<leader>il', function()
  local servers = {}
  for _, server in ipairs(vim.lsp.get_active_clients()) do
    table.insert(servers, server.name)
  end
  print("Attached LSP servers: " .. table.concat(servers, ', '))
end, {})
--}}}

-- clear highlights, close popups, redraw screen to fix bunch of render bugs
map('n', '<esc>', ':nohlsearch<cr>:pclose<cr><c-l>', { desc = "close things, nohl" })

-- when moving more than 5 lines , then make a jump , to be able to revert via c-o
map('n', 'j', [[(v:count > 5 ? "m'" . v:count : "") . 'gj']], { expr = true })
map('n', 'k', [[(v:count > 5 ? "m'" . v:count : "") . 'gk']], { expr = true })

map('n', '<leader>sns', ':source ~/.config/nvim/plugin/completion.lua<cr>', { desc = "[sn]ippet [s]ource" })
map('n', 'gx', ":execute '!open ' . shellescape(expand('<cWORD>')    , 1)<cr>")
map('n', '<leader>M', '<cmd>Messages<cr>', { desc = "[M]essages" })
map('n', '<leader>dts', [[mz:%s/ \+$//<cr>`z<cr>]]) -- delete trailing spaces
map({ 'i', 'n' }, '<M-s>', '<cmd>:Format<cr>:FixAll<cr>:w<cr>', { silent = true })
map('n', 'z0', 'zMzvzz')
map('n', 'ì', 'zMzvzz') -- alt v
map('n', 'à', 'za') -- alt z
map('n', "<C-d>", "<C-d>zz")
map('n', "<C-u>", "<C-u>zz")

-- Refactoring {{{

-- prompt for a refactor to apply when the remap is triggered
vim.api.nvim_set_keymap("v", "<leader>rr", ":lua require('refactoring').select_refactor()<CR>",
  { noremap = true, silent = true, expr = false })

-- Remaps for the refactoring operations currently offered by the plugin
vim.api.nvim_set_keymap("v", "<leader>re", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]],
  { noremap = true, silent = true, expr = false })
vim.api.nvim_set_keymap("v", "<leader>rf",
  [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>]],
  { noremap = true, silent = true, expr = false })
vim.api.nvim_set_keymap("v", "<leader>rv", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>]],
  { noremap = true, silent = true, expr = false })
vim.api.nvim_set_keymap("v", "<leader>ri", [[ <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]],
  { noremap = true, silent = true, expr = false })

-- Extract block doesn't need visual mode
vim.api.nvim_set_keymap("n", "<leader>rb", [[ <Cmd>lua require('refactoring').refactor('Extract Block')<CR>]],
  { noremap = true, silent = true, expr = false })
vim.api.nvim_set_keymap("n", "<leader>rbf", [[ <Cmd>lua require('refactoring').refactor('Extract Block To File')<CR>]],
  { noremap = true, silent = true, expr = false })

-- Inline variable can also pick up the identifier currently under the cursor without visual mode
vim.api.nvim_set_keymap("n", "<leader>ri", [[ <Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]],
  { noremap = true, silent = true, expr = false }) -- }}}

map('n', '<leader>cp', ':Format<cr>')
map('n', '<leader>.', ':Telescop code_action<cr>')

map('n', 'gV', '`[v`]') -- visual select last inserted text)

map('n', '<leader>gc', ':normal yygccp<cr>')
map('n', '<leader>gC', ':normal yipgcipP<cr>')

-- move text around
map('v', '<c-k>', ":m '<-2<CR>gv=gv")
map('v', '<c-j>', ":m '>+1<CR>gv=gv")

-- TODO: convert these into lua
vim.cmd([[
" write and close buffer
cnoreabb wd w\|:bd
" path to current file's folder, useful for :e %%
cnoremap <expr> %%  getcmdtype() == ':' ? expand('%:h').'/' : '%%'
]])

map('x', 'ga', '<Plug>(EasyAlign)')
map('n', 'ga', '<Plug>(EasyAlign)')


-- }}}

-- vim: nowrap fen fdl=0
