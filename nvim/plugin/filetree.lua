local baggage = require 'baggage'.from {
  'https://github.com/nvim-tree/nvim-tree.lua'
}

local with_setup = baggage.lazy_setup("nvim-tree", {
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


vim.keymap.set({ "n" }, "<leader>tt", with_setup(function()
  require "nvim-tree.api".tree.toggle({
    find_file = true
  })
end))

vim.keymap.set({ "n" }, "<M-0>", with_setup(function()
  require "nvim-tree.api".tree.toggle({
    find_file = true
  })
end))

vim.keymap.set({ "n" }, "<leader>tf", with_setup(function()
  require "nvim-tree.api".tree.open()
end))
