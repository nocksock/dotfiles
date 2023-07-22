local function map(mode, key, command, opts)
  opts = vim.tbl_extend('force', { noremap = true, silent = true }, opts or {})
  vim.keymap.set(mode, key, command, opts)
end

-- Toggles
map('n', '<leader>ti', function()
  local previous = vim.diagnostic.config()
  vim.diagnostic.config({
    virtual_text = not previous.virtual_text
  })
end, { desc = "[t]oggle [i]nlay hints" })

-- infos {{{
map('n', '<leader>il', function()
  local servers = {}
  for _, server in ipairs(vim.lsp.get_active_clients()) do
    table.insert(servers, server.name)
  end
  print("Attached LSP servers: " .. table.concat(servers, ', '))
end, {})
--}}}


-- vim: nowrap fen fdl=0
