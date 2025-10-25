local lspconfig = require("lspconfig")

lspconfig.denols.setup {
  autostart = false,
  capabilities = require "lsp-utils".capabilities,
  file_types   = { 'js', 'ts', },
  root_dir     = require('lspconfig.util').root_pattern("deno.json", "deno.jsonc"),
  cmd          = { "deno", "lsp" },
  on_attach    = require "lsp-utils".on_attach
}
