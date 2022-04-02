require('zen-mode').setup({
	-- your configuration comes here
	-- or leave it empty to use the default settings
	-- refer to the configuration section below
	plugins = {
		kitty = {
			enabled = true,
			font = '+4',
		},
		twilight = {
			enabled = false,
		},
		tmux = {
			enabled = true,
		},
		gitsigns = {
			enabled = true,
		},
		options = {
			enabled = true,
			showcmd = false,
		},
	},

	window = {
		backdrop = 0.75,
		width = 120,
		options = {
			signcolumn = 'no',
			number = false,
			relativenumber = false,
			list = false,
		},
	},
})

require('twilight').setup({
	dimming = {
		inactive = true,
	},
})
