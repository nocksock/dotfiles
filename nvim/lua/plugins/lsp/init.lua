return {
  --- lspconfig
  {
    "VonHeikemen/lsp-zero.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      'rmagatti/goto-preview', -- open gotos in floating windows
      "neovim/nvim-lspconfig",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      { 'j-hui/fidget.nvim', config = true }, -- fidget.nvim: ui for nvm-lsp progress
      'github/copilot.vim',
      'ray-x/lsp_signature.nvim',             -- show function signatures from LSP when typing
      'folke/trouble.nvim',                   -- pretty list for LSP diagnostics
    },
    config = function() require "configs.lsp" end
  },
  {
    'jose-elias-alvarez/typescript.nvim', -- more ts lsp stuff
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      { 'windwp/nvim-ts-autotag', opts = { update_on_insert = true } }, -- use TreeSitter to close and rename tags
      'jose-elias-alvarez/null-ls.nvim',                                -- use neovim as ls server to inject code-actions and mor via lua
      "lbrayner/vim-rzip",
      "marilari88/twoslash-queries.nvim",                               -- // ^?
    },
  }
}
