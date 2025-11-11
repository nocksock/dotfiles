vim.lsp.config("svelte",{
  capabilities = require "lsp-utils".capabilities,
  root_dir     = require('lspconfig.util').root_pattern("svelte.config.js"),
})
