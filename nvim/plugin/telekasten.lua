local home = vim.fn.expand('~/notes')
require('telekasten').setup({
	home = home,
	dailies = home .. '/' .. 'daily',
	weeklies = home .. '/' .. 'weekly',
	templates = home .. '/' .. 'templates',

	-- markdown file extension
	extension = '.md',
})
