require("mason").setup({})

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
local lspconfig = require('lspconfig')

local handlers = {
      ["window/progress"] = function(params, client_id, bufnr, config)
    params.value.title = "[" .. params.value.kind .. "] " .. params.value.title
    vim.lsp.util.window_progress(params, client_id, bufnr, config)
  end,
}


lspconfig.rust_analyzer.setup {}

lspconfig.pyright.setup {}

lspconfig.gopls.setup {}

lspconfig.lua_ls.setup({
  capabilities = capabilities,
  handlers = handlers,
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      telemetry = { enable = false },
      diagnostics = {
        globals = {
          'vim',
        },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file('', true), -- Make the server aware of Neovim runtime files
        checkThirdParty = false,
      },
    },
  },
})

lspconfig.clangd.setup({
  capabilities = capabilities,
  cmd = { "clangd", "--background-index", "--clang-tidy" --[[ , "--header-insertion=iwyu" ]] },
  init_options = {
    clangdFileStatus = true
  },
})

lspconfig.denols.setup {
  handlers     = handlers,
  capabilities = capabilities,
  root_dir     = require('lspconfig.util').root_pattern("deno.json", "deno.jsonc"),
}

lspconfig.svelte.setup {
  handlers     = handlers,
  capabilities = capabilities,
  root_dir     = require('lspconfig.util').root_pattern("svelte.config.js"),
}

-- TypeScript {{{
-- Using the plugin since it adds some useful commands
require("typescript").setup({
  server = {
    capabilities = capabilities,
    single_file_support = false,
    root_dir = lspconfig.util.root_pattern("package.json"),
    on_attach = function(client, bufnr)
      local keyopts = { noremap = true, silent = true, buffer = bufnr }
      require("twoslash-queries").attach(client, bufnr)

      vim.keymap.set('n', "<leader><C-k>", "<cmd>InspectTwoslashQueries<CR>", keyopts)
      vim.keymap.set('n', '<leader>fi', ':TypescriptAddMissingImports<cr>', keyopts)
      vim.keymap.set('n', '<leader>fo', ':TypescriptOrganizeImports<cr>', keyopts)
      vim.keymap.set('n', '<leader>fu', ':TypescriptRemoveUnused<cr>', keyopts)
      vim.keymap.set('n', '<leader>fA',
        ':TypescriptAddMissingImports<cr>:TypescriptAddMissingImports<CR>:TypescriptRemoveUnused<CR>', keyopts)
      vim.keymap.set('n', '<leader>rN', ':TypescriptRenameFile<cr>', keyopts)

    end,
  }
})
--}}}

lspconfig.sourcekit.setup({
  capabilities = capabilities,
  handlers = handlers,
})

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local bufnr = args.buf
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    if client.server_capabilities.completionProvider then
      vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
    end

    if client.server_capabilities.definitionProvider then
      vim.bo[bufnr].tagfunc = "v:lua.vim.lsp.tagfunc"
    end

    vim.api.nvim_buf_set_option(0, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    vim.api.nvim_buf_set_option(0, 'formatexpr', 'v:lua.vim.lsp.formatexpr()')

    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', '<leader>K', vim.lsp.buf.signature_help, bufopts)

    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, bufopts)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, bufopts)
    vim.keymap.set('n', "]e", function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR }) end,
      bufopts)
    vim.keymap.set('n', "[e", function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR }) end,
      bufopts)

    vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, bufopts)
    vim.keymap.set('n', '<leader>q', ':Diagnostics<cr>', bufopts)
    vim.keymap.set('n', '<leader>Q', ':Diagnostics error<cr>', bufopts)

    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<leader>wl', function() print(vim.inspect(vim.lspjbuf.list_workspace_folders())) end, bufopts)
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)

    vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)

    vim.keymap.set('n', 'gsd', ':vs<cr>:lua vim.lsp.buf.definition()<cr>zt', bufopts)
    vim.keymap.set('n', 'gsD', ':vs<cr>:lua vim.lsp.buf.declaration()<cr>zt', bufopts)
    vim.keymap.set('n', 'gst', ':vs<cr>:lua vim.lsp.buf.type_definition()<cr>zt', bufopts)
    vim.keymap.set('n', 'gsi', ':vs<cr>:lua vim.lsp.buf.implementation()<cr>zt', bufopts)

    vim.keymap.set('n', 'gpd', require('goto-preview').goto_preview_definition, bufopts)
    vim.keymap.set('n', 'gpi', require('goto-preview').goto_preview_implementation, bufopts)
    vim.keymap.set('n', 'gpt', require('goto-preview').goto_preview_type_definition, bufopts)
    vim.keymap.set('n', 'gpr', require('goto-preview').goto_preview_references, bufopts)
    vim.keymap.set('n', 'gpc', require('goto-preview').close_all_win, bufopts)
  end
})
-- vi: fen fdl=0 fdm=marker fmr={{{,}}} fdc=3
