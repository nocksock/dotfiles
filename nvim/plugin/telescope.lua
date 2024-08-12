local baggage = require 'baggage'
    .from {
      'https://github.com/nvim-telescope/telescope.nvim',
      'https://github.com/nvim-telescope/telescope-ui-select.nvim',
      { 'https://github.com/nvim-telescope/telescope-fzf-native.nvim', on_sync = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build" }
    }

local action_state = require "telescope.actions.state"
local actions = require "telescope.actions"

require 'telescope'.setup({
  defaults = {
    mappings = {
      i = {
        ['<c-f>'] = function(buf)
          local entry = action_state.get_selected_entry()[1]
          actions.close(buf)
          vim.api.nvim_put({ entry }, "", true, true)
        end,
        ['<c-j>'] = actions.move_selection_next,
        ['<c-k>'] = actions.move_selection_previous
      },
      n = {
        ['<Down>'] = "cycle_history_next",
        ['<Up>'] = "cycle_history_prev",
        ['<c-f>'] = "insert_symbol",
      }
    },
    layout_strategy = 'horizontal',
    layout_config = { height = 0.95, width = 0.95 },
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

require 'telescope'.load_extension 'ui-select'
require 'telescope'.load_extension 'fzf'

local nmap = require 'nmap'
local t = function(builtin, opts)
  return function() require('telescope.builtin')[builtin](opts or {}) end
end


nmap('<leader>f', t 'find_files')
nmap('<leader>*', t 'grep_string')
nmap('<leader>g', t 'live_grep')
nmap('<leader><leader>', t('buffers'))
nmap('<leader>:', t 'commands')
nmap('<leader>S', t 'lsp_dynamic_workspace_symbols')
nmap('<leader>s', t 'lsp_document_symbols')
nmap('<leader>/', t 'current_buffer_fuzzy_find')
nmap('<leader><c-r>', t 'command_history')
nmap('<leader>H', t 'help_tags')
nmap('<leader><cr>', t 'resume')
nmap('<leader>C', t 'colorschemes')
nmap('<leader>T', t 'builtin')

-- First, ensure Telescope is loaded
require('telescope').setup {}

vim.keymap.set("i", "<C-x><C-f>", function()
  require("telescope.builtin").find_files({
    attach_mappings = function(_, map)
      local function insert_path(prompt_bufnr)
        local entry = require("telescope.actions.state").get_selected_entry()
        require("telescope.actions").close(prompt_bufnr)
        vim.api.nvim_put({ entry.path }, "", true, true)
      end
      map("n", "<cr>", insert_path)
      map("i", "<cr>", insert_path)
      return true
    end,
  })
end, { silent = true, desc = "Fuzzy complete file" })
