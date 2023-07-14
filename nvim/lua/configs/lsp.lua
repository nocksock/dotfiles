require("mason").setup({})
local lspconfig = require('lspconfig')

require("lsp_signature").setup {
  bind = true,
  handler_opts = {
    border = "rounded",
    toggle_key = "<c-i>"
  }
}

lspconfig.rust_analyzer.setup {
  on_attach = require("snock.lsp").on_attach,
}

lspconfig.pyright.setup {
  on_attach = require("snock.lsp").on_attach,
}

lspconfig.gopls.setup {
  on_attach = require("snock.lsp").on_attach,
}

lspconfig.lua_ls.setup({
  on_attach = require("snock.lsp").on_attach,
  Lua = {
    workspace = {
      library = vim.api.nvim_get_runtime_file('', true), -- Make the server aware of Neovim runtime files
      checkThirdParty = false,
    },
    telemetry = { enable = false },
  },
})

lspconfig.clangd.setup({
  capabilities = require('snock.lsp').capabilities(),
  on_attach = require("snock.lsp").on_attach,
  cmd = { "clangd", "--background-index", "--clang-tidy" --[[ , "--header-insertion=iwyu" ]] },
  init_options = {
    clangdFileStatus = true
  },
})

lspconfig.denols.setup {
  on_attach    = require("snock.lsp").on_attach,
  handlers     = require('snock.lsp').handlers,
  capabilities = require('snock.lsp').capabilities(),
  root_dir     = require('lspconfig.util').root_pattern("deno.json", "deno.jsonc"),
}

require("lspconfig").tsserver.setup({
  capabilities        = require('snock.lsp').capabilities(),
  on_attach           = require("snock.lsp").on_attach,
  handlers            = require('snock.lsp').handlers,
  root_dir            = require('lspconfig.util').root_pattern("package.json"),
  single_file_support = false,
})

-- vi: fen fdl=0 fdm=marker fmr={{{,}}} fdc=3
