require('twilight').setup({})
require('zen-mode').setup({
	plugins = {
		kitty = {
			enabled = true,
			font = '+4',
		},
		twilight = {
			enabled = true,
		},
		tmux = {
			enabled = true,
		},
		gitsigns = {
			enabled = true,
		},
		options = {
			enabled = true,
			showcmd = true,
		},
	},
	window = {
		backdrop = 0.75,
		width = 120,
		options = {
			signcolumn = 'yes',
			number = false,
			relativenumber = false,
			list = false,
		},
	},
})

