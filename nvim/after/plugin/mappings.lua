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
local x = prefix "[x] globals"

--}}}

map('n', '_', ':vnew .<cr>') -- open netrw in side pslit
map('n', '<c-f>', 'z') -- I use folds a lot, this takes some load off of my pinky

--
-- Buffer {{{
map('n', '<leader>bd', ':b#|bd#<cr>', b("[D]elete    , keep layout"))
map('n', '<leader>bD', ':bd', b("[D]elete"))
map('n', '<leader>bO', ':%bd|e#<cr>', b("[O]nly"))
--}}}
-- Terminal {{{
map('n', '<F12>', ':Ts<CR>i')
map('t', '<F12>', [[<C-\><C-n>:T<CR>]])

-- better terminal exits
map('t', '<c-[>', '<C-\\><C-n>')
map('t', '<Esc>', '<C-\\><C-n>')
-- }}}

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
-- Toggles {{{
map('n', '<leader>ti', function()
  local previous = vim.diagnostic.config()
  vim.diagnostic.config({
    virtual_text = not previous.virtual_text
  })
end, { desc = "[t]oggle [i]nlay hints"})
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


map('n', '<leader>cp', ':Format<cr>')
map('n', '<M-.>', ':Telescop code_action<cr>')

map('n', 'gV', '`[v`]') -- visual select last inserted text)

map('n', '<leader>gc', ':normal yygccp<cr>')
map('n', '<leader>gC', ':normal yipgcipP<cr>')

-- move text around
map('v', '<c-k>', ":m '<-2<CR>gv=gv")
map('v', '<c-j>', ":m '>+1<CR>gv=gv")

-- -- TODO: convert these into lua
vim.cmd([[
" write and close buffer
cnoreabb wd w\|:bd
" path to current file's folder, useful for :e %%
cnoremap <expr> %%  getcmdtype() == ':' ? expand('%:h').'/' : '%%'
]])

-- }}}

--
-- vim: nowrap fen fdl=0
