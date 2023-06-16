require('lspconfig').sourcekit.setup({
  on_attach = require("snock.lsp").on_attach,
  capabilities = require('snock.lsp').capabilities(),
  handlers = require('snock.lsp').handlers,
})

