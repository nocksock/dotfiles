require 'baggage'.from {
  'https://github.com/nvim-tree/nvim-tree.lua'
}

vim.opt.termguicolors = true
require("nvim-tree").setup({
  hijack_netrw = false,
  actions = {
    change_dir = {
      enable = false
    }
  },
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})

local api = require "nvim-tree.api"

vim.keymap.set({ "n" }, "<leader>tt", function()
  api.tree.toggle({
    find_file = true
  })
end)

vim.keymap.set({ "n" }, "<M-0>", function()
  api.tree.toggle({
    find_file = true
  })
end)

vim.keymap.set({ "n" }, "<leader>tf", function()
  api.tree.open()
end)
