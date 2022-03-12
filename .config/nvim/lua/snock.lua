-- plugins {{{
require('packer').startup(function(use)
	use('wbthomason/packer.nvim') -- packer can manage itself

	-- general purppose plugins
	use('tpope/vim-abolish') -- working with words (drastic understatement)
	use('alvan/vim-closetag') -- auto close html/jsx tags
	use('tpope/vim-surround') -- quoting/parenthesizing made simple. extends functionality of s
	use('tpope/vim-repeat') -- makes . even more powerful by adding suppor for plugins
	use('tpope/vim-commentary') -- comment stuff out and back in via gc/gcc
	use('tpope/vim-eunuch') -- vim sugar for the unix shell commands that need it the most. like :delete, :move, :chmod
	use('jiangmiao/auto-pairs') -- auto insert/delete brackets, parens, quotes etc
	use('editorconfig/editorconfig-vim') -- loads settings from .editoconfig if present
	use('godlygeek/tabular') -- align text at character. more powerful than :!column
	use('sirver/ultisnips') -- ultimate snippet manager, still the best.

	-- scripting
	use('nvim-lua/popup.nvim')
	use('nvim-lua/plenary.nvim') -- util functions. a dependency of many plugins

	-- treesitter
	use('nvim-treesitter/nvim-treesitter')
	use('nvim-treesitter/playground')
	use('theprimeagen/refactoring.nvim')

	-- process management etc
	use('voldikss/vim-floaterm') -- floating terminal
	use('tpope/vim-dadbod') -- make db connections from within vim
	use('kristijanhusak/vim-dadbod-ui') -- ui for vim-dadbox

	-- git
	use('simnalamburt/vim-mundo') -- browser for vim's undo tree, for when git is not enough
	use('lewis6991/gitsigns.nvim') -- show diff markers in the gutter + gitlens
	use('tpope/vim-fugitive') -- a git wrapper in vim
	use('junegunn/gv.vim') -- commit browser

	-- auto-completion
	use('hrsh7th/cmp-nvim-lsp')
	use('hrsh7th/cmp-buffer')
	use('hrsh7th/cmp-path')
	use('hrsh7th/cmp-cmdline')
	use('hrsh7th/nvim-cmp')
	use('quangnguyen30192/cmp-nvim-ultisnips')

	-- file navigation
	use('nvim-telescope/telescope.nvim')
	use({ 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' })
	use('tpope/vim-vinegar') --  improved netrw for file browsing.
	use('mcchrish/nnn.vim')

	-- lsp
	use('neovim/nvim-lspconfig') --  easy configs for language servers
	use('jose-elias-alvarez/null-ls.nvim')
	use('jose-elias-alvarez/nvim-lsp-ts-utils')

	-- looks and themes
	use('pantharshit00/vim-prisma') --  syntax for prisma file
	use('sheerun/vim-polyglot') -- tons of syntax
	use('rktjmp/lush.nvim') -- for easily creating colorschemes via dsl
	use('~/personal/bloop-vim') -- my own colorscheme, work in progress, available at github.com/nocksock/bloop-vim
	use('nlknguyen/papercolor-theme') -- for moments I need a bright theme
end)
--}}}
require('gitsigns').setup({})

-- treesitter {{{
require('nvim-treesitter.configs').setup({
	highlight = {
		enable = false, -- TODO: adjust bloop-theme to be compatible with tree-sitter groups
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
Refactors = extensions.refactoring.refactors
-- }}}
-- LSP {{{
local lspconfig = require('lspconfig')
local cmp_nvim_lsp = require('cmp_nvim_lsp')
local null_ls = require('null-ls')

local function ts_organize_imports()
	local params = {
		command = '_typescript.organizeImports',
		arguments = { vim.api.nvim_buf_get_name(0) },
		title = '',
	}
	vim.lsp.buf.execute_command(params)
end

local on_attach = function(client, bufnr)
	local map = function(bnr, mode, lhs, rhs, opts)
		vim.api.nvim_buf_set_keymap(bnr, mode, lhs, rhs, opts or {})
	end

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
	map(bufnr, 'n', 'ga', ':Telescope lsp_code_action<CR>')
	map(bufnr, 'n', '<Leader>ld', ':LspDiagLine<CR>')
	map(bufnr, 'i', '<C-x><C-x>', '<cmd> LspSignatureHelp<CR>')
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
		null_ls.builtins.diagnostics.eslint,
		null_ls.builtins.code_actions.eslint,
		null_ls.builtins.formatting.prettier,
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
lspconfig.gopls.setup({})

-- }}}
-- completion {{{
local cmp = require('cmp')

cmp.setup({
	snippet = {
		expand = function(args)
			vim.fn['UltiSnips#Anon'](args.body) -- For `ultisnips` users.
		end,
	},
	mapping = {
		['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
		['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
		['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
		['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
		['<C-e>'] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),
		['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	},
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'ultisnips' }, -- For ultisnips users.
	}, {
		{ name = 'buffer' },
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


-- vim:fdl=0 fdm=marker
