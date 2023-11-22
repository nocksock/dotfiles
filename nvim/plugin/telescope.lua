require 'baggage'
    .from {
      'https://github.com/nvim-telescope/telescope.nvim',
      'https://github.com/nvim-telescope/telescope-ui-select.nvim',
      { 'https://github.com/nvim-telescope/telescope-fzf-native.nvim', { on_sync = "make" } }
    }
    .load 'telescope'

local action_state = require "telescope.actions.state"
local actions = require "telescope.actions"

require'telescope'.setup({
  defaults = {
    mappings = {
      i = {
        ['<c-f>'] = function(buf)
          local entry = action_state.get_selected_entry()[1]
          actions.close(buf)
          vim.api.nvim_put({ entry }, "", true, true)
        end
      },
      n = {
        ['<Down>'] = "cycle_history_next",
        ['<Up>'] = "cycle_history_prev",
        ['<c-f>'] = "insert_symbol",
      }
    },
    layout_strategy = 'vertical',
  },
  pickers = {
    buffers = {
      sort_lastused = true,
      path_display = { "smart" },
      mappings = {
        n = {
          ["dd"] = "delete_buffer"
        }
      }
    }
  },
  extensions = {
    fzf = {
      fuzzy = true,                   -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true,    -- override the file sorter
    },
  },
})

require'telescope'.load_extension('fzf')
