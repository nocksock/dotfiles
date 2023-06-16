require('lspconfig').lua_ls.setup({
  on_attach = require("snock.lsp").on_attach,
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
