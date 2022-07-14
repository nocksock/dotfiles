local telekastenHome = vim.fn.expand(
	'/Users/nilsriedemann/Library/Mobile Documents/iCloud~md~obsidian/Documents/Development'
)

require('telekasten').setup({
	home = telekastenHome,
	dailies = telekastenHome .. '/' .. 'Journal',
	weeklies = telekastenHome .. '/' .. 'Journal',
	templates = telekastenHome .. '/' .. 'Templates',
	subdirs_in_links = false,
	-- markdown file extension
	extension = '.md',
})

