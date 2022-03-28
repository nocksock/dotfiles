local telescope = require('telescope')
telescope.setup({
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

local home = vim.fn.expand("~/notes")
require('telekasten').setup({
		home = home,
    dailies      = home .. '/' .. 'daily',
    weeklies     = home .. '/' .. 'weekly',
    templates    = home .. '/' .. 'templates',

    -- markdown file extension
    extension    = ".md",
})
