return {
  {
    'kyazdani42/nvim-tree.lua',
    keys = {
      { '<leader>tt', function() require("nvim-tree.api").tree.toggle() end,  desc = "toggle filetree" }
    },
    opts = {
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
    }
  }
}
