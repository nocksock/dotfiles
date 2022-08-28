local tree = require('nvim-tree')
local api = require('nvim-tree.api')

tree.setup({
  hijack_cursor = true,
  hijack_netrw = false,
  view = {
    preserve_window_proportions = true,
    side = "right",
    centralize_selection = true
  },
  diagnostics = {
    enable = true
  },
  renderer = {
    icons = {
      git_placement = "after"
    }
  },
  actions = {
    change_dir = {
      enable = false
    },
    expand_all = {
      exclude = { ".git", "node_modules" }
    }
  }
})

return api.tree
