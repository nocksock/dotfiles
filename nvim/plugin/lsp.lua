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
	on_attach = function(client, bufnr)
		client.server_capabilities.documentFormatting = false
		client.server_capabilities.documentRangeFormatting = false

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

local null_augroup = vim.api.nvim_create_augroup("LspFormatting", {})
null_ls.setup({
	sources = {
		null_ls.builtins.formatting.prettier,
		null_ls.builtins.formatting.stylua,
	},
	on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = null_augroup, buffer = bufnr})
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = null_augroup,
        buffer = bufnr,
        callback = function ()
          vim.lsp.buf.format({ bufnr = bufnr })
        end
      })
    end
  end,
})

local runtime_path = vim.split(package.path, ';')

table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

-- via nvim-lsp-config
--    https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#sumneko_lua
lspconfig.sumneko_lua.setup({
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

lspconfig.tailwindcss.setup({
	on_attach = function(client, bufnr)
		require('tailwind-highlight').setup(client, bufnr, {})
	end,
})

lspconfig.gopls.setup({
	on_attach = on_attach,
})

lspconfig.omnisharp.setup({
	capabilities = require('cmp_nvim_lsp').update_capabilities(
		vim.lsp.protocol.make_client_capabilities()
	),
	on_attach = function(_, bufnr)
		vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
	end,
	cmd = {
		'~/bin/omnisharp-osx/run',
		'--languageserver',
		'--hostPID',
		tostring(pid),
	},
})
