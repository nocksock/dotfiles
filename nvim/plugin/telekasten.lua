local home = vim.fn.expand(
	'/Users/nilsriedemann/Library/Mobile Documents/iCloud~md~obsidian/Documents/Development'
)

require('telekasten').setup({
	home = home,
	dailies = home .. '/' .. 'Dailies',
	weeklies = home .. '/' .. 'weekly',
	templates = home .. '/' .. 'templates',
	subdirs_in_links = false,

	-- markdown file extension
	extension = '.md',
})
