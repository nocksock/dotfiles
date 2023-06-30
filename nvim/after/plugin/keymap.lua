local function map(mode, key, command, opts)
  opts = vim.tbl_extend('force', { noremap = true, silent = true }, opts or {})
  vim.keymap.set(mode, key, command, opts)
end

-- Buffer 
map('n', '<leader>bd', ':b#|bd#<cr>', { desc = "delete buffer, keep layout" })
map('n', '<leader>bO', ':%bd|e#<cr>', { desc = "delete all other buffers" })

-- Toggles 
map('n', '<leader>ti', function()
  local previous = vim.diagnostic.config()
  vim.diagnostic.config({
    virtual_text = not previous.virtual_text
  })
end, { desc = "[t]oggle [i]nlay hints"})

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

map('n', '<leader>sns', ':source ~/.config/nvim/plugin/completion.lua<cr>', { desc = "[sn]ippet [s]ource" })
map({ 'i', 'n' }, '<M-s>', '<cmd>:Format<cr>:FixAll<cr>:w<cr>', { silent = true })

-- vim: nowrap fen fdl=0
