local baggage = require "baggage"
    .from {
      'https://github.com/neovim/nvim-lspconfig',
      'https://github.com/williamboman/mason.nvim',
      'https://github.com/elixir-tools/elixir-tools.nvim',
      'https://github.com/hrsh7th/cmp-nvim-lsp'
    }

local lspconfig = require 'lspconfig'

-- lspconfig.util.default_config = vim.tbl_extend(
--   "force",
--   lspconfig.util.default_config,
--   { 
--     on_attach = require("lsp-utils").on_attach,
--     -- autostart = false
--   }
-- )

require 'mason'.setup {
  ensure_installed = {
    "clangd",
    "cssls",
    "cssmodules_ls",
    "denols",
    "eslint",
    "gopls",
    "lua_ls",
    "marksman",
    "pyright",
    "rust_analyzer",
    "sourcekit",
    "svelte",
    "tailwindcss",
  }
}
