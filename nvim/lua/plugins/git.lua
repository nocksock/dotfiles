return {
  {
    'tpope/vim-fugitive', -- a git wrapper in vim
    event = { "BufReadPost", "BufNewFile" },
    keys = {
      { '<leader>gg', ':tab G<cr>' },
      { '<leader>cc', ':Git commit<cr>' },
    }
  },
  {
    'lewis6991/gitsigns.nvim',
    event = { "BufReadPost", "BufNewFile" },
    keys = {
      -- local gitsigns = require('gitsigns.actions')
      { '<leader>hn', "<cmd>Gitsigns next_hunk<CR>" },
      { '<leader>hp', "<cmd>Gitsigns prev_hunk<CR>" },
      { '<leader>hs', function() require("gitsigns.actions").stage_hunk() end,      desc = 'stage hunk' },
      { '<leader>hs', function() require("gitsigns.actions").stage_hunk() end,      desc = 'stage hunk' },
      { '<leader>hr', function() require("gitsigns.actions").reset_hunk() end,      desc = 'reset hunk' },
      { '<leader>hr', function() require("gitsigns.actions").reset_hunk() end,      desc = 'reset hunk' },
      { '<leader>hu', function() require("gitsigns.actions").undo_stage_hunk() end, desc = 'undo stage' },
      { '<leader>hS', function() require("gitsigns.actions").stage_buffer() end,    desc = 'stage buffer' },
      { '<leader>hR', function() require("gitsigns.actions").reset_buffer() end,    desc = 'reset buffer' },
      { '<leader>hp', function() require("gitsigns.actions").preview_hunk() end,    desc = 'preview hunk' },
      { '<leader>hb', ':lua require"gitsigns".blame_line{full=true}<CR>',           desc = "blame line" },
      { '<leader>hd', function() require("gitsigns.actions").diffthis() end,        desc = "diff this hunk" },
      { '<leader>hD', function() require "gitsigns".diffthis("~") end,              desc = "diff directory" },
      { 'ic',         function() require("gitsigns.actions").select_hunk() end,     mode = "o",             desc =
      "select hunk" },
      { 'ic',         function() require("gitsigns.actions").select_hunk() end,     mode = "x",             desc =
      "select hunk" },
    },
    config = true
  }
}
