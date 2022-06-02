require('nvim-treesitter.configs').setup({
	highlight = {
		enable = true,
		-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
		-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
		-- Using this option may slow down your editor, and you may see some duplicate highlights.
		-- Instead of true it can also be a list of languages
		additional_vim_regex_highlighting = false,
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = 'gnv',
			node_incremental = 'gna',
			scope_incremental = 'gnA',
			node_decremental = 'gni',
		},
	},
})

require('refactoring').setup({})
