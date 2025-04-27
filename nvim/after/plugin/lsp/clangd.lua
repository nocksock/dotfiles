require "lspconfig".clangd.setup({
  capabilities = require "lsp-utils".capabilities,
  cmd = { "clangd", "--background-index", "--clang-tidy" --[[ , "--header-insertion=iwyu" ]] },
  init_options = {
    clangdFileStatus = true
  },
})
