-- TODO: try out minuet with local llm
require 'baggage'.from {
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/zbirenbaum/copilot.lua',
}

vim.g.copilot_no_tab_map = true

require("copilot").setup({
    filetypes = {
        ["*"] = false,
        ["elixir"] = true,
        ["heex"] = true,
        ["javascript"] = true
    },
})
