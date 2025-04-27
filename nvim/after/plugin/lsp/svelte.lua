require "lspconfig".svelte.setup {
  capabilities = require "lsp-utils".capabilities,
  root_dir     = require('lspconfig.util').root_pattern("svelte.config.js"),
}
