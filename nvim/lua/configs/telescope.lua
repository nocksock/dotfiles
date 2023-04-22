local telescope = require('telescope')

telescope.load_extension('fzf')
telescope.load_extension('refactoring')
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
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
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
