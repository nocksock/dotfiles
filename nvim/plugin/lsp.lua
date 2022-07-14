local lspconfig = require('lspconfig')
local cmp_nvim_lsp = require('cmp_nvim_lsp')
local null_ls = require('null-ls')
local util = require('vim.lsp.util')
local builtin = require('telescope.builtin')

local map = function(bufnr, mode, lhs, rhs, opts)
  vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts or {})
end

local function list_workspace_folders()
  print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end

local on_attach = function(_, bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  local cmd = function(name, func)
    vim.api.nvim_create_user_command(name, func, {})
  end

  cmd('LspDef', vim.lsp.buf.definition)
  cmd('LspFormatting', vim.lsp.buf.formatting)
  cmd('LspCodeAction', vim.lsp.buf.code_action)
  cmd('LspHover', vim.lsp.buf.hover)
  cmd('LspRename', vim.lsp.buf.rename)
  cmd('LspRefs', vim.lsp.buf.references)
  cmd('LspTypeDef', vim.lsp.buf.type_definition)
  cmd('LspImplementation', vim.lsp.buf.implementation)
  cmd('LspDiagPrev', vim.diagnostic.goto_prev)
  cmd('LspDiagNext', vim.diagnostic.goto_next)
  cmd('LspDiagLine', vim.diagnostic.open_float)
  cmd('LspSignatureHelp', vim.lsp.buf.signature_help)

  nmap('<leader>.', vim.lsp.buf.code_action, 'Code Action (vscodey)')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type Definition')
  nmap('<leader>ds', builtin.lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>rN', vim.lsp.buf.rename, '[R]e[N]ame File')
  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wl', list_workspace_folders, '[W]orkspace [L]ist Folders')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>ws', builtin.lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('gi', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('gr', builtin.lsp_references)

  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
  vim.keymap.set('i', '<C-k>', vim.lsp.buf.hover)

  print('LSP bindings enabled') -- todo: add indicator to statusline if LSP is running
end

local servers = { 'clangd', 'terraformls', 'pyright', 'tsserver', 'sumneko_lua', 'gopls', 'eslint' }
local capabilities = cmp_nvim_lsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())

require('nvim-lsp-installer').setup {
  ensure_installed = servers,
}

for _, lsp in ipairs(servers) do
  require('lspconfig')[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

lspconfig.tsserver.setup({
  on_attach = function(client, bufnr)
    local ts_utils = require('nvim-lsp-ts-utils')

    ts_utils.setup({})
    ts_utils.setup_client(client)

    map(bufnr, 'n', 'gs', ':TSLspOrganize<CR>')
    map(bufnr, 'n', 'go', ':TSLspImportAll<CR>')

    on_attach(client, bufnr)

    client.server_capabilities.document_formatting = false -- 0.7 and earlier
  end,
  commands = {
    OrganizeImports = {
      function()
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
  },
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = null_augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = null_augroup,
        buffer = bufnr,
        callback = function()
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
        version = 'LuaJIT', -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        path = runtime_path, -- Setup your lua path
      },
      diagnostics = {
        globals = { 'vim' }, -- Get the language server to recognize the `vim` global
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file('', true), -- Make the server aware of Neovim runtime files
      },
      telemetry = {
        enable = false, -- Do not send telemetry data containing a randomized but unique identifier
      },
    },
  },
  on_attach = on_attach,
})
