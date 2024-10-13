local bag = require 'baggage'.from {
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/nvim-treesitter/nvim-treesitter",
  "https://github.com/hrsh7th/nvim-cmp",
  "https://github.com/nvim-telescope/telescope.nvim",
  "https://github.com/stevearc/dressing.nvim",
  "https://github.com/olimorris/codecompanion.nvim",
}

require("codecompanion").setup({
  strategies = {
    chat = {
      adapter = "anthropic",
    },
    inline = {
      adapter = "anthropic",
    },
  },
  adapters = {
    anthropic = function()
      return require("codecompanion.adapters").extend("anthropic", {
        env = {
          api_key = "cmd:op read op://bleepbloop/anthropic/credential --no-newline",
        },
      })
    end
  },
})

vim.api.nvim_set_keymap("n", "<Localleader>a", "<cmd>CodeCompanionActions<cr>",     { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<Localleader>a", "<cmd>CodeCompanionActions<cr>",     { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<LocalLeader>c", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<LocalLeader>c", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<Localleader>y", "<cmd>CodeCompanionChat Add<cr>",    { noremap = true, silent = true })
