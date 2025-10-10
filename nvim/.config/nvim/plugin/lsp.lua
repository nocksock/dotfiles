local baggage = require "baggage"
  .from {
    'https://github.com/neovim/nvim-lspconfig',
    'https://github.com/williamboman/mason.nvim',
    'https://github.com/elixir-tools/elixir-tools.nvim',
    'https://github.com/hrsh7th/cmp-nvim-lsp'
  }

local lspconfig = require 'lspconfig'
-- Configuration of languages servers happening in ../after/plugin/lsp/

require 'mason'.setup {
  ensure_installed = {
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
    "tailwindcss",
  }
}
