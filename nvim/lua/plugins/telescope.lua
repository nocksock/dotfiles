return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-live-grep-args.nvim",
    "nvim-telescope/telescope-file-browser.nvim",
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make', },
    "nvim-telescope/telescope-ui-select.nvim"
  },
  -- stylua: ignore
  keys = {
    { '<leader><space>', ":Telescope buffers<cr>", desc = 'Find existing buffers' },
    { '<leader><cr>', ":Telescope resume<cr>", desc = 'resume previous search' },
    { '<leader>T', ":Telescope builtin<cr>", desc = 'builtin Telescope commands' },
    { '<leader>/', ':Telescope current_buffer_fuzzy_find<cr>', desc = 'Fuzzily search in current buffer' },
    { '<C-P>', ":Telescope find_files hidden=true<cr>", desc = 'search files' },
    { '<C-B>', ":Telescope buffers<cr>", desc = 'Find existing buffers' },
    { '<M-C-P>', ":Telescope commands<cr>", desc = 'search commands' },
    { '<leader>sC', ":Telescope colorscheme enable_preview=true<cr>", desc = "search colors" },
    { '<M-r>', ':Telescope lsp_dynamic_workspace_symbols<cr>', desc = 'workspace symbols' },
    { '<leader>-', ":Telescope file_browser path=%:p:h<cr>", desc = 'search files' },
    { '<leader>sr', ":Telescope oldfiles<cr>", desc = 'search ecently opened files' },
    { '<leader>sh', ":Telescope help_tags<cr>", desc = 'search help' },
    { '<leader>sc', ":Telescope commands<cr>", desc = 'search commands' },
    { '<leader>*', ":Telescope grep_string<cr>", desc = 'search current [w]ord' },
    { '<leader>gb', ":Telescope git_branches<cr>", desc = 'git branches' },
    { '<leader>gs', ':Telescope git_status<cr>', desc = 'git status' },
    { '<leader>sg', ":lua require('telescope'}.extensions.live_grep_args.live_grep_args(}<cr>", desc = 'search by grep' },
    { '<leader>sp', ":lua R('snock.plugins.search-plugins'}.search(}<cr>", desc = 'plugins' },
  },
  config = function()
    require "configs.search-plugins"
    local telescope = require('telescope')

    telescope.load_extension('fzf')
    -- telescope.load_extension('refactoring')
    telescope.load_extension("live_grep_args")
    telescope.load_extension("file_browser")
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
            ["ui-select"] = {
          require("telescope.themes").get_dropdown {
            -- even more opts
          }

          -- pseudo code / specification for writing custom displays, like the one
          -- for "codeactions"
          -- specific_opts = {
          --   [kind] = {
          --     make_indexed = function(items) -> indexed_items, width,
          --     make_displayer = function(widths) -> displayer
          --     make_display = function(displayer) -> function(e)
          --     make_ordinal = function(e) -> string
          --   },
          --   -- for example to disable the custom builtin "codeactions" display
          --      do the following
          --   codeactions = false,
          -- }
        }
      },
    })

    local builtin = require('telescope.builtin')

    local function search_in(path, search_fn) -- {{{
      local options = { hidden = true }

      if path ~= nil then
        local xpath = vim.fn.expand(path)
        options = vim.tbl_extend("force", options, {
          search_dirs = { xpath },
          cwd = xpath, -- setting this trims the path
        })
      end

      builtin[vim.F.if_nil(search_fn, "find_files")](options)
    end --}}}

    return vim.tbl_extend("keep", builtin, {
      search_in = search_in
    })
  end
}
