local telescope = require('telescope')
telescope.setup({
	defaults = {
		mappings = {
			i = {
				['<C-Down>'] = require('telescope.actions').cycle_history_next,
				['<C-Up>'] = require('telescope.actions').cycle_history_prev,
			},
		},
		windblend = 90,
		path_display = {},
		layout_strategy = 'vertical',
		layout_config = {
			height = 0.95,
			width = 0.75,
			prompt_position = 'bottom',
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

local home = vim.fn.expand('~/notes')
require('telekasten').setup({
	home = home,
	dailies = home .. '/' .. 'daily',
	weeklies = home .. '/' .. 'weekly',
	templates = home .. '/' .. 'templates',

	-- markdown file extension
	extension = '.md',
})
