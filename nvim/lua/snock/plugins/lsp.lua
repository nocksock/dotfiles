require("mason").setup({})
require('goto-preview').setup {}
require("trouble").setup {}
require("lsp_signature").setup {}
require("symbols-outline").setup {}

local lspconfig = require('lspconfig')
local cmp_nvim_lsp = require('cmp_nvim_lsp')
local null_ls = require('null-ls')
local builtin = require('telescope.builtin')

local servers = { 'clangd', 'tsserver', 'sumneko_lua', 'gopls', 'bashls' }
local manual_servers = { 'tsserver', 'sumneko_lua' }
local capabilities = cmp_nvim_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())

require("mason-lspconfig").setup({ ensure_installed = servers })

-- add rounded borders to vim.lsp.buf.hover and signatureHelp
local handlers = {
  ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
  ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
}

-- function on_attach, runs when LSP is connected {{{
local on_attach = function(client, bufnr)
  local nmap = function(keys, func, desc)
    if desc then desc = 'LSP: ' .. desc end
    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end
  local cmd = function(name, func) vim.api.nvim_create_user_command(name, func, {}) end

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

  cmd('Format', function()
    if vim.lsp.buf.format then
      vim.lsp.buf.format()
    elseif vim.lsp.buf.formatting then
      vim.lsp.buf.formatting()
    end
  end)

  cmd('FixAll', function()
    if vim.lsp.buf.code_action then
      vim.lsp.buf.code_action({
        apply = true,
        filter = function(action)
          return action.command.command == "eslint.applyAllFixes"
        end
      })
    end
  end)

  -- mappings {{{
  nmap('<leader>ss', builtin.lsp_dynamic_workspace_symbols, 'workspace symbols')
  nmap('<leader>ca', vim.lsp.buf.code_action, 'Code Action (vscodey)')
  nmap('<F2>', vim.lsp.buf.rename, 'rename symbol under cursor')

  nmap('<leader>ff', ':Format<cr>', 'format file')
  nmap('<leader>fa', ':FixAll<cr>', 'fix all autofixables')

  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type Definition')
  nmap('<leader>ds', builtin.lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
    '[W]orkspace [L]ist Folders')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('gr', require('telescope.builtin').lsp_references)

  nmap('gd', vim.lsp.buf.definition, '[g]oto [d]efinition')
  nmap('gD', vim.lsp.buf.declaration, '[g]oto [D]eclaration')
  nmap('gi', vim.lsp.buf.implementation, '[g]oto [i]mplementation')

  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<leader>K', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- preview
  nmap('gpd', require('goto-preview').goto_preview_definition)
  nmap('gpi', require('goto-preview').goto_preview_implementation)
  nmap('gpt', require('goto-preview').goto_preview_type_definition)
  nmap('gpr', require('goto-preview').goto_preview_references)
  nmap('gP', require('goto-preview').close_all_win)
  --}}}
end --}}}

-- autoconfig of lsps {{{
require("mason-lspconfig").setup_handlers({
  function(server_name) -- default handler (optional)
    if vim.tbl_contains(manual_servers, server_name) then
      return -- do not autoconfig these
    end

    require("lspconfig")[server_name].setup {
      on_attach = on_attach,
      capabilities = capabilities,
      handlers = handlers
    }
  end,
}) -- }}}

-- TypeScript {{{
require("typescript").setup({
  server = {
    capabilities = capabilities,
    handlers = handlers,
    on_attach = function(client, bufnr)
      vim.keymap.set('n', '<leader>fi', ':TypescriptAddMissingImports<cr>', { buffer = bufnr })
      vim.keymap.set('n', '<leader>fo', ':TypescriptOrganizeImports<cr>', { buffer = bufnr })
      vim.keymap.set('n', '<leader>fu', ':TypescriptRemoveUnused<cr>', { buffer = bufnr })
      vim.keymap.set('n', '<leader>fA',
        ':TypescriptAddMissingImports<cr>:TypescriptAddMissingImports<CR>:TypescriptRemoveUnused<CR>', { buffer = bufnr })
      vim.keymap.set('n', '<leader>rN', ':TypescriptRenameFile<cr>', { buffer = bufnr })

      on_attach(client, bufnr)
    end,
  }
})
--}}}

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
}) --}}}

null_ls.setup({ -- {{{
  sources = {
    null_ls.builtins.formatting.prettier,
  },
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
  end,
})
-- }}}

-- vi: fen fdl=0
