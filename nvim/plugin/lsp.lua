-- for now based on this guide
-- https://jose-elias-alvarez.medium.com/configuring-neovims-lsp-client-for-typescript-development-5789d58ea9c
local lspconfig = require('lspconfig')
local cmp_nvim_lsp = require('cmp_nvim_lsp')
local null_ls = require('null-ls')
local util = require('vim.lsp.util')

local map = function(bufnr, mode, lhs, rhs, opts)
	vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts or {})
end

local on_attach = function(_, bufnr)
	local nmap = function(keys, func, desc)
		if desc then
			desc = 'LSP: ' .. desc
		end

		vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
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

	nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
	nmap('<leader>rN', vim.lsp.buf.rename, '[R]e[N]ame File')
	nmap('<leader>.', vim.lsp.buf.code_action, 'Code Action (vscodey)')

	nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
	nmap('gi', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
	nmap('gr', require('telescope.builtin').lsp_references)
	nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
	nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

	nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
	nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

	-- Lesser used LSP functionality
	nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
	nmap('<leader>D', vim.lsp.buf.type_definition, 'Type Definition')
	nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
	nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
	nmap('<leader>wl', function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, '[W]orkspace [L]ist Folders')

	print('LSP bindings enabled') -- todo: add indicator to statusline if LSP is running
end

cmp_nvim_lsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())

local formatting_callback = function(client, bufnr)
  vim.keymap.set('n', '<leader>f', function()
    local params = util.make_formatting_params({})
    client.request('textDocument/formatting', params, nil, bufnr)
  end, {buffer = bufnr})
end

lspconfig.tsserver.setup({
	on_attach = function(client, bufnr)
		local ts_utils = require('nvim-lsp-ts-utils')

		ts_utils.setup({})
		ts_utils.setup_client(client)

		map(bufnr, 'n', 'gs', ':TSLspOrganize<CR>')
		map(bufnr, 'n', 'go', ':TSLspImportAll<CR>')

    formatting_callback(client, bufnr)
		on_attach(client, bufnr)

    client.server_capabilities.document_formatting = false -- 0.7 and earlier
	end,
	commands = {
		OrganizeImports = {
      function ()
        local params = {
          command = '_typescript.organizeImports',
          arguments = { vim.api.nvim_buf_get_name(0) },
          title = '',
        }
        vim.lsp.buf.execute_command(params)
      end,
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
          local params = util.make_formatting_params({})
          client.request('textDocument/formatting', params, nil, bufnr)
				end
			})
    else
      print('no formatting supported')
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
      format = {
        enable = true,
        defaultConfig = {
            indent_style = "space",
            indent_size = "2",
        }
      },
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

lspconfig.gopls.setup({
  on_attach = on_attach,
})
