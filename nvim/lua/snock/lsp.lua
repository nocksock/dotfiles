-- imports {{{
require("fidget").setup {}
require('goto-preview').setup {}
require("trouble").setup {}
require("lsp_signature").setup {}
require("symbols-outline").setup {}

local lspconfig = require('lspconfig')
local cmp_nvim_lsp = require('cmp_nvim_lsp')
local null_ls = require('null-ls')
local util = require('vim.lsp.util')
local builtin = require('telescope.builtin')
local saga = require("lspsaga")

saga.init_lsp_saga({
  code_action_lightbulb = {
    enable = false,
    enable_in_insert = false,
    sign = false,
    update_time = 150,
    sign_priority = 20,
    virtual_text = false,
  }
})
-- }}}

local servers = { 'clangd', 'terraformls', 'pyright', 'tsserver', 'sumneko_lua', 'gopls', 'eslint', 'astro', 'sourcekit', 'bashls' }
local null_augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local capabilities = cmp_nvim_lsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- add rounded borders to vim.lsp.buf.hover and signatureHelp
local handlers = {
  ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
  ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
}

-- Helper functions {{{
local map = function(bufnr, mode, lhs, rhs, opts)
  vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts or {})
end

local function list_workspace_folders()
  print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end

-- }}}
-- on_attach callback {{{
local on_attach = function(client, bufnr)
  -- local helpers nmap, cmd {{{
  local nmap = function(keys, func, desc)
    if desc then desc = 'LSP: ' .. desc end
    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end
  local cmd = function(name, func) vim.api.nvim_create_user_command(name, func, {}) end
  -- }}}

  require "lsp_signature".on_attach({
    bind = true, -- This is mandatory, otherwise border config won't get registered.
    handler_opts = {
      border = "rounded"
    }
  }, bufnr)

  -- highlight references under cursor {{{
  if client.server_capabilities.documentHighlightProvider then
    vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
    vim.api.nvim_clear_autocmds { buffer = bufnr, group = "lsp_document_highlight" }
    vim.api.nvim_create_autocmd("CursorHold", {
      callback = vim.lsp.buf.document_highlight,
      buffer = bufnr,
      group = "lsp_document_highlight",
    })
    vim.api.nvim_create_autocmd("CursorMoved", {
      callback = vim.lsp.buf.clear_references,
      buffer = bufnr,
      group = "lsp_document_highlight",
    })
  end
  --}}}
  -- commands {{{
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
  --}}}
  -- mappings {{{
  nmap('<M-r>', builtin.lsp_document_symbols, '[s]search document [s]ymbols')
  nmap('<M-.>', ':Lspsaga code_action<cr>', 'Code Action (vscodey)')
  nmap('<F2>', vim.lsp.buf.rename, '[R]e[n]ame')

  nmap('<leader>.', ':Lspsaga code_action<cr>', 'Code Action (vscodey)')
  nmap('<leader>e', vim.diagnostic.open_float)
  nmap('<leader>q', vim.diagnostic.setloclist)
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type Definition')
  nmap('<leader>ds', builtin.lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wl', list_workspace_folders, '[W]orkspace [L]ist Folders')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>sS', builtin.lsp_document_symbols, '[s]search document [s]ymbols')
  nmap('<leader>ss', builtin.lsp_dynamic_workspace_symbols, '[s]search workspace [S]ymbols')
  nmap('gr', '<cmd>Lspsaga lsp_finder<cr>')
  nmap('gd', vim.lsp.buf.definition, '[g]oto [d]efinition')
  nmap('gD', vim.lsp.buf.declaration, '[g]oto [D]eclaration')
  nmap('gi', vim.lsp.buf.implementation, '[g]oto [i]mplementation')
  nmap('<leader>k', ':Lspsaga diagnostic_jump_prev<cr>')
  nmap('<leader>j', ':Lspsaga diagnostic_jump_next<cr>')
  nmap("<leader>K", function()
    require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
  end)
  nmap("<leader>J", function()
    require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
  end)

  -- preview
  nmap('gpd', require('goto-preview').goto_preview_definition)
  nmap('gpi', require('goto-preview').goto_preview_implementation)
  nmap('gP', require('goto-preview').close_all_win)
  nmap('gpr', require('goto-preview').goto_preview_references)
  --}}}

  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<leader>K', vim.lsp.buf.signature_help, 'Signature Documentation')
end --}}}
-- Base setup {{{
require('nvim-lsp-installer').setup { ensure_installed = servers, }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    handlers = handlers
  }
end
-- }}}
-- TypeScript {{{
lspconfig.tsserver.setup({
  on_attach = function(client, bufnr)
    local ts_utils = require('nvim-lsp-ts-utils')

    ts_utils.setup({})
    ts_utils.setup_client(client)

    map(bufnr, 'n', 'go', '<cmd>TSLspOrganize<CR>')
    map(bufnr, 'n', 'gO', '<cmd>TSLspImportAll<CR><cmd>TSLspOrganize<cr>')

    on_attach(client, bufnr)

    client.server_capabilities.document_formatting = false
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
}) --}}}
-- Lua {{{
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
        globals = { 'vim', 'hs' }, -- Get the language server to recognize the `vim` global
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
}) --}}}

-- Null LS {{{
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
          -- todo: request code-action autofix autofixable
        end
      })
    else
      print('no formatting supported')
    end
  end,
}) --}}}


-- vi: fen fdl=0
