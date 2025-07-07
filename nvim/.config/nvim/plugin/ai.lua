require 'baggage'.from {
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/nvim-treesitter/nvim-treesitter",
  "https://github.com/hrsh7th/nvim-cmp",
  "https://github.com/nvim-telescope/telescope.nvim",
  "https://github.com/stevearc/dressing.nvim",
  "https://github.com/olimorris/codecompanion.nvim",
  "https://github.com/github/copilot.vim.git"
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

vim.api.nvim_set_keymap("n", "<Localleader>ca", "<cmd>CodeCompanionActions<cr>",     { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<Localleader>ca", "<cmd>CodeCompanionActions<cr>",     { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<LocalLeader>cc", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<LocalLeader>cc", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<LocalLeader>cpd", "<cmd>Copilot disable<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<LocalLeader>cpe", "<cmd>Copilot enable<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<Localleader>cy", "<cmd>CodeCompanionChat Add<cr>",    { noremap = true, silent = true })
