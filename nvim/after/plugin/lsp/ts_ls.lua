local lspconfig = require("lspconfig")

lspconfig.ts_ls.setup {
  init_options = {
    hostInfo = "neovim",
    tsserver = {
      -- logToFile = true,
      logLevel = "verbose"
    }
  },
  capabilities = require "lsp-utils".capabilities,
  file_types   = { 'js', 'ts', },
  root_dir     = require('lspconfig.util').root_pattern("deno.json", "deno.jsonc", "package.json"),
  on_attach    = require "lsp-utils".on_attach
}
