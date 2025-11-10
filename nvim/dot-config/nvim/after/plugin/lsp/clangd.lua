vim.lsp.config('clangd', {
  capabilities = require "lsp-utils".capabilities,
  cmd = { "clangd", "--background-index", "--clang-tidy" },
  init_options = {
    clangdFileStatus = true
  },
})
