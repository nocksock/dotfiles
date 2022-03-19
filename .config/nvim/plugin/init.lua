-- plugins {{{
require('packer').startup({
	function(use)
		-- fyi, I prefer using github urls, because they're easier to work with (copy,
		-- paste, clickable) and more explicit.
		use('https://github.com/wbthomason/packer.nvim') -- packer can manage itself
		-- general purppose plugins {{{
		use('https://github.com/tpope/vim-abolish') -- working with words (drastic understatement)
		use('https://github.com/alvan/vim-closetag') -- auto close html/jsx tags
		use('https://github.com/tpope/vim-surround') -- quoting/parenthesizing made simple. extends functionality of s
		use('https://github.com/tpope/vim-repeat') -- makes . even more powerful by adding suppor for plugins
		use('https://github.com/tpope/vim-eunuch') -- vim sugar for the unix shell commands that need it the most. like :delete, :move, :chmod
		use('https://github.com/jiangmiao/auto-pairs') -- auto insert/delete brackets, parens, quotes etc
		use('https://github.com/editorconfig/editorconfig-vim') -- loads settings from .editoconfig if present
		use('https://github.com/godlygeek/tabular') -- align text at character. more powerful than :!column
		use({ '~/personal/rucksack.nvim', requires = 'nvim-lua/plenary.nvim' }) -- stash away code for later re-user across sessions: https://github.com/nocksock/rucksack.nvim
		use('https://github.com/dstein64/vim-startuptime') -- find the startup bottleneck
		use('https://github.com/numToStr/Comment.nvim') -- comments, with neat smartnesses
		use('https://github.com/folke/zen-mode.nvim') -- distraction free writing and some other nice things
		use('https://github.com/folke/twilight.nvim') -- highlight only portion of text
		use('https://github.com/L3MON4D3/LuaSnip')
		--}}}
		--
		-- scripting {{{
		use('https://github.com/nvim-lua/popup.nvim')
		use('https://github.com/tpope/vim-scriptease') -- helper commands useful when writing vim scripts etc
		use('https://github.com/nvim-lua/plenary.nvim') -- util functions. a dependency of many plugins
		-- }}}
		-- treesitter{{{
		use('https://github.com/nvim-treesitter/nvim-treesitter')
		use('https://github.com/nvim-treesitter/playground')
		use('https://github.com/theprimeagen/refactoring.nvim')
		--}}},,
		-- process management etc {{{
		use('https://github.com/voldikss/vim-floaterm') -- floating terminal
		use('https://github.com/tpope/vim-dadbod') -- make db connections from within vim
		use('https://github.com/kristijanhusak/vim-dadbod-ui') -- ui for vim-dadbox
		-- git {{{
		use('https://github.com/simnalamburt/vim-mundo') -- browser for vim's undo tree, for when git is not enough
		use('https://github.com/lewis6991/gitsigns.nvim') -- show diff markers in the gutter + gitlens
		use('https://github.com/tpope/vim-fugitive') -- a git wrapper in vim
		use('https://github.com/junegunn/gv.vim') -- commit browser
		--}}}
		-- auto-completion via nvim-cmp{{{
		use('https://github.com/hrsh7th/nvim-cmp')
		use('https://github.com/hrsh7th/cmp-path')
		use('https://github.com/hrsh7th/cmp-buffer')
		use('https://github.com/hrsh7th/cmp-cmdline')
		use('https://github.com/hrsh7th/cmp-nvim-lua')
		use('https://github.com/hrsh7th/cmp-nvim-lsp')
		-- }}},
		-- file navigation{{{
		use('https://github.com/nvim-telescope/telescope.nvim')
		use({
			'https://github.com/nvim-telescope/telescope-fzf-native.nvim',
			run = 'make',
		})
		use('https://github.com/tpope/vim-vinegar') -- improved netrw for file browsing.
		use('https://github.com/mcchrish/nnn.vim') -- using nnn in a floating window (and open file in vim)
		use('https://github.com/renerocksai/telekasten.nvim') -- zettelkasten within vim
		use('https://github.com/nvim-telescope/telescope-symbols.nvim')
		--}}}
		-- lsp{{{
		use('https://github.com/neovim/nvim-lspconfig') --  easy configs for language servers
		use('https://github.com/jose-elias-alvarez/null-ls.nvim')
		use('https://github.com/jose-elias-alvarez/nvim-lsp-ts-utils')
		--}}}
		-- looks and themes{{{
		use('https://github.com/pantharshit00/vim-prisma') --  syntax for prisma file
		use('https://github.com/sheerun/vim-polyglot') -- tons of syntax, but slows down startup time
		use('https://github.com/rktjmp/lush.nvim') -- for easily creating colorschemes via dsl
		use('https://github.com/nlknguyen/papercolor-theme') -- for moments I need a bright theme
		use('~/personal/bloop-vim') -- my own colorscheme, work in progress, available at github.com/nocksock/bloop-vim
		use('https://github.com/rafi/awesome-vim-colorschemes')
		use('https://github.com/tomasr/molokai')
		use('https://github.com/ayu-theme/ayu-vim')
		--}}}
	end,
	config = {
		profile = {
			enable = true,
			threshold = 2,
		},
	},
})
--}}}
--}}}
-- treesitter {{{
require('nvim-treesitter.configs').setup({
	highlight = {
		enable = false,
		-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
		-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
		-- Using this option may slow down your editor, and you may see some duplicate highlights.
		-- Instead of true it can also be a list of languages
		additional_vim_regex_highlighting = false,
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = 'gnn',
			node_incremental = 'grn',
			scope_incremental = 'grc',
			node_decremental = 'grm',
		},
	},
})

require('refactoring').setup({})
-- }}}
-- Telescope {{{
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
require('telekasten').setup({})
-- }}}
-- LSP {{{
-- for now based on this guide
-- https://jose-elias-alvarez.medium.com/configuring-neovims-lsp-client-for-typescript-development-5789d58ea9c
local lspconfig = require('lspconfig')
local cmp_nvim_lsp = require('cmp_nvim_lsp')
local null_ls = require('null-ls')

local map = function(bufnr, mode, lhs, rhs, opts)
	vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts or {})
end

local function ts_organize_imports()
	local params = {
		command = '_typescript.organizeImports',
		arguments = { vim.api.nvim_buf_get_name(0) },
		title = '',
	}
	vim.lsp.buf.execute_command(params)
end

local on_attach = function(client, bufnr)
	vim.cmd('command! LspDef lua vim.lsp.buf.definition()')
	vim.cmd('command! LspFormatting lua vim.lsp.buf.formatting()')
	vim.cmd('command! LspCodeAction lua vim.lsp.buf.code_action()')
	vim.cmd('command! LspHover lua vim.lsp.buf.hover()')
	vim.cmd('command! LspRename lua vim.lsp.buf.rename()')
	vim.cmd('command! LspRefs lua vim.lsp.buf.references()')
	vim.cmd('command! LspTypeDef lua vim.lsp.buf.type_definition()')
	vim.cmd('command! LspImplementation lua vim.lsp.buf.implementation()')
	vim.cmd('command! LspDiagPrev lua vim.diagnostic.goto_prev()')
	vim.cmd('command! LspDiagNext lua vim.diagnostic.goto_next()')
	vim.cmd('command! LspDiagLine lua vim.diagnostic.open_float()')
	vim.cmd('command! LspSignatureHelp lua vim.lsp.buf.signature_help()')

	map(bufnr, 'n', 'gd', ':LspDef<CR>')
	map(bufnr, 'n', 'gr', ':LspRefs<CR>')
	map(bufnr, 'n', 'gD', ':LspTypeDef<CR>')
	map(bufnr, 'n', 'K', ':LspHover<CR>')
	map(bufnr, 'n', '[d', ':LspDiagPrev<CR>')
	map(bufnr, 'n', ']d', ':LspDiagNext<CR>')
	map(bufnr, 'n', 'ga', ':Telescope lsp_code_actions<CR>')
	map(bufnr, 'n', '<Leader>ld', ':LspDiagLine<CR>')
	map(bufnr, 'i', '<C-x><C-x>', '<cmd> LspSignatureHelp<CR>')

	print('LSP bindings enabled') -- todo: add indicator to statusline if LSP is running
end

cmp_nvim_lsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())

lspconfig.tsserver.setup({
	capabilities = capabilities,
	on_attach = function(client, bufnr)
		client.resolved_capabilities.document_formatting = false
		client.resolved_capabilities.document_range_formatting = false

		local ts_utils = require('nvim-lsp-ts-utils')

		ts_utils.setup({})
		ts_utils.setup_client(client)

		map(bufnr, 'n', 'gs', ':TSLspOrganize<CR>')
		map(bufnr, 'n', 'gi', ':TSLspRenameFile<CR>')
		map(bufnr, 'n', 'go', ':TSLspImportAll<CR>')

		on_attach(client, bufnr)
	end,
	commands = {
		OrganizeImports = {
			ts_organize_imports,
			description = 'Organize Imports',
		},
	},
})

null_ls.setup({
	sources = {
		-- null_ls.builtins.diagnostics.eslint,
		-- null_ls.builtins.code_actions.eslint,
		null_ls.builtins.formatting.prettier,
		null_ls.builtins.formatting.stylua,
	},
	on_attach = on_attach,
})

local runtime_path = vim.split(package.path, ';')

table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

-- via nvim-lsp-config
--    https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#sumneko_lua
lspconfig.sumneko_lua.setup({
	capabilities = capabilities,
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = 'LuaJIT',
				-- Setup your lua path
				path = runtime_path,
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { 'vim' },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file('', true),
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
	on_attach = on_attach,
})

lspconfig.tailwindcss.setup({})
lspconfig.gopls.setup({
		on_attach = on_attach
	})

-- }}}
-- completion {{{
local cmp = require('cmp')

cmp.setup({
	snippet = {
		expand = function(args)
			--vim.fn['UltiSnips#Anon'](args.body) -- For `ultisnips` users.
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
		end,
	},
	mapping = {
		['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
		['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
		['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
		['<C-y>'] = cmp.mapping.confirm({
				behavior = cmp.ConfirmBehavior.Insert,
				select = true
			}), -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
		['<C-e>'] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),
		['<CR>'] = cmp.mapping.confirm({ select = false }),
		['<C-l>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				return cmp.complete_common_string()
			end
			fallback()
		end, { 'i', 'c' }),
	},
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' },
	}, {
		{ name = 'buffer', keyword_length = 5 },
	}),
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
	sources = cmp.config.sources({
		{ name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
	}, {
		{ name = 'buffer' },
	}),
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
	sources = {
		{ name = 'buffer' },
	},
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
	sources = cmp.config.sources({
		{ name = 'path' },
	}, {
		{ name = 'cmdline' },
	}),
})
-- }}}
-- gitsigns {{{

require('gitsigns').setup({
	on_attach = function(bufnr)
		local function map(mode, lhs, rhs, opts)
			opts = vim.tbl_extend('force', { noremap = true, silent = true }, opts or {})
			vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
		end

		-- Navigation
		map('n', ']c', "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", { expr = true })
		map('n', '[c', "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", { expr = true })

		-- Actions
		map('n', '<leader>hs', ':Gitsigns stage_hunk<CR>')
		map('v', '<leader>hs', ':Gitsigns stage_hunk<CR>')
		map('n', '<leader>hr', ':Gitsigns reset_hunk<CR>')
		map('v', '<leader>hr', ':Gitsigns reset_hunk<CR>')
		map('n', '<leader>hS', '<cmd>Gitsigns stage_buffer<CR>')
		map('n', '<leader>hu', '<cmd>Gitsigns undo_stage_hunk<CR>')
		map('n', '<leader>hR', '<cmd>Gitsigns reset_buffer<CR>')
		map('n', '<leader>hp', '<cmd>Gitsigns preview_hunk<CR>')
		map('n', '<leader>hb', '<cmd>lua require"gitsigns".blame_line{full=true}<CR>')
		map('n', '<leader>hd', '<cmd>Gitsigns diffthis<CR>')
		map('n', '<leader>hD', '<cmd>lua require"gitsigns".diffthis("~")<CR>')

		map('n', '<leader>tb', '<cmd>Gitsigns toggle_current_line_blame<CR>')
		map('n', '<leader>td', '<cmd>Gitsigns toggle_deleted<CR>')

		-- Text object
		map('o', 'ih', ':<C-U>Gitsigns select_hunk<CR>')
		map('x', 'ih', ':<C-U>Gitsigns select_hunk<CR>')
	end,
})

-- }}}

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
			enabled = false
		},
		tmux = {
			enabled = true,
		},
		gitsigns = {
			enabled = true,
		},
		options = {
			enabled = true,
			showcmd = false
		}
	},

	window = {
		backdrop = 0.75,
		width = 120,
		options = {
			signcolumn = "no",
			number = false,
			relativenumber = false,
			list = false,
		},
	},
})

require('twilight').setup {
	dimming = {
		inactive = true
	}
}


require('comment').setup {}
-- vim:fdm=marker fdl=9
