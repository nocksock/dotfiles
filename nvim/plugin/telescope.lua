local telescope = require('telescope')
telescope.setup({
	defaults = {
		mappings = {
			i = {
				['<C-Down>'] = require('telescope.actions').cycle_history_next,
				['<C-Up>'] = require('telescope.actions').cycle_history_prev,
			},
		},
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
