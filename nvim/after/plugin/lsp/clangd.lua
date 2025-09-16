require "lspconfig".clangd.setup({
  capabilities = require "lsp-utils".capabilities,
  cmd = { "clangd", "--background-index", "--clang-tidy" },
  init_options = {
    clangdFileStatus = true
  },
})
