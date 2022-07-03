local telescope = require('telescope')

telescope.setup({
	defaults = {
		mappings = {
			n = {
				['<Down>'] = require('telescope.actions').cycle_history_next,
				['<Up>'] = require('telescope.actions').cycle_history_prev,
			}
		},
		layout_strategy = 'vertical',
	},
	extensions = {
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
		},
	},
})

telescope.load_extension('fzf')
telescope.load_extension('refactoring')

