local client = vim.lsp.start({
  cmd = { 'sourcekit-lsp' },
  root_dir = require('snock.utils').root_dir(
    { 'Package.swift', 'buildServer.json', 'compile_commands.json', '.git' }
  ),
  on_attach = function(client, bufnr)
    require("lsp-keymaps").register(client, bufnr)
  end
})

vim.lsp.buf_attach_client(0, client)
