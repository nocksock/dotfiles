local telescope = R('telescope')

telescope.load_extension('fzf')
telescope.load_extension('refactoring')

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
      mappings = {
        i = {
          ["<c-d>"] = "delete_buffer"
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
	},
})


