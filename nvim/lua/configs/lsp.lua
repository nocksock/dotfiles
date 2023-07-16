require("mason").setup({})
local lspconfig = require('lspconfig')

require("lsp_signature").setup {
  bind = true,
  handler_opts = {
    border = "rounded",
    toggle_key = "<c-i>"
  }
}

lspconfig.rust_analyzer.setup { }

lspconfig.pyright.setup { }

lspconfig.gopls.setup { }

lspconfig.lua_ls.setup({
  capabilities = require('snock.lsp').capabilities(),
  handlers = require('snock.lsp').handlers,
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      telemetry = { enable = false },
      diagnostics = {
        globals = {
          'vim',
          "vim",
        },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file('', true), -- Make the server aware of Neovim runtime files
        checkThirdParty = false,
      },
    },
  },
})

lspconfig.clangd.setup({
  capabilities = require('snock.lsp').capabilities(),
  cmd = { "clangd", "--background-index", "--clang-tidy" --[[ , "--header-insertion=iwyu" ]] },
  init_options = {
    clangdFileStatus = true
  },
})

lspconfig.denols.setup {
  handlers     = require('snock.lsp').handlers,
  capabilities = require('snock.lsp').capabilities(),
  root_dir     = require('lspconfig.util').root_pattern("deno.json", "deno.jsonc"),
}

lspconfig.tsserver.setup({
  capabilities        = require('snock.lsp').capabilities(),
  handlers            = require('snock.lsp').handlers,
  root_dir            = require('lspconfig.util').root_pattern("package.json"),
  single_file_support = false,
})

lspconfig.sourcekit.setup({
  capabilities = require('snock.lsp').capabilities(),
  handlers = require('snock.lsp').handlers,
})

-- vi: fen fdl=0 fdm=marker fmr={{{,}}} fdc=3
