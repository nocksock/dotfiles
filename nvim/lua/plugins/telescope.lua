return {
  {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-live-grep-args.nvim",
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make', },
    "nvim-telescope/telescope-ui-select.nvim"
  },
  cmd = { "Telescope" },
  -- stylua: ignore
  keys = {
    { '<leader><cr>', ":Telescope resume<cr>", desc = 'resume previous search' },
    { '<leader>T', ":Telescope builtin<cr>", desc = 'builtin Telescope commands' },
    { '<leader>/', ':Telescope current_buffer_fuzzy_find<cr>', desc = 'Fuzzily search in current buffer' },
    { '<leader>f', ":Telescope find_files hidden=true<cr>", desc = 'search files' },
    { '<c-p>', ":Telescope find_files hidden=true<cr>", desc = 'search files' },
    { '<leader>b', ":Telescope buffers<cr>", desc = 'Find existing buffers' },
    { '<c-b>', ":Telescope buffers<cr>", desc = 'Find existing buffers' },
    { '<leader>sC', ":Telescope colorscheme enable_preview=true<cr>", desc = "search colors" },
    { '<M-r>', ':Telescope lsp_dynamic_workspace_symbols<cr>', desc = 'workspace symbols' },
    { '<leader>-', ":Telescope file_browser path=%:p:h<cr>", desc = 'search files' },
    { '<leader>sr', ":Telescope oldfiles<cr>", desc = 'search ecently opened files' },
    { '<leader>sh', ":Telescope help_tags<cr>", desc = 'search help' },
    { '<leader>sc', ":Telescope commands<cr>", desc = 'search commands' },
    { '<leader>*', ":Telescope grep_string<cr>", desc = 'search current word' },
    { '<leader>gb', ":Telescope git_branches<cr>", desc = 'git branches' },
    { '<leader>gs', ':Telescope git_status<cr>', desc = 'git status' },
    { '<leader>sg', ":lua require('telescope').extensions.live_grep_args.live_grep_args()<cr>", desc = 'search by grep' },
    { '<leader>sp', ":lua R('snock.plugins.search-plugins'}.search(}<cr>", desc = 'plugins' },
  },
  config = function()
    local telescope = require('telescope')

    telescope.load_extension('fzf')
    telescope.load_extension("live_grep_args")
    telescope.load_extension("ui-select")

    telescope.setup({
      defaults = {
        mappings = {
          i = {
                ['<C-E>'] = "insert_symbol",
          },
          n = {
                ['<Down>'] = "cycle_history_next",
                ['<Up>'] = "cycle_history_prev",
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
  end,
  },
  {
    'junegunn/fzf', install = ':execute fzf#install()',
    event = 'VeryLazy',
    dependencies = {
      {
        'junegunn/fzf.vim',
        keys = {
          -- { '<c-/>', ':Lines<cr>', desc = 'Fuzzily search in current buffer' },
          -- { '<C-B>', ":Buffers<cr>", desc = 'list open buffers' },
          -- { '<C-P>', ":Files<cr>", desc = 'search files' },
        }
      }
    }
  },

}
