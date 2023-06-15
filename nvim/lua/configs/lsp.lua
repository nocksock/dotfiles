require("mason").setup({})
require('goto-preview').setup {}
require("trouble").setup {}
require("symbols-outline").setup {}
require("lsp_signature").setup {
  bind = true,
  handler_opts = {
    border = "single",
    toggle_key = "<c-i>"
  }
}


local cmp_nvim_lsp = require('cmp_nvim_lsp')
local null_ls = require('null-ls')
local runtime_path = vim.split(package.path, ';')

table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

local capabilities = cmp_nvim_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())

local servers = {
  clangd = {
    capabilities = capabilities,
    cmd = { "clangd", "--background-index", "--clang-tidy" --[[ , "--header-insertion=iwyu" ]] },
    -- root_dir = lspconfig.util.root_pattern("compile_commands.json", "compile_flags.txt", ".git"),
    init_options = {
      clangdFileStatus = true,
      -- usePlaceholders = true,
      -- completeUnimported = true,
      -- semanticHighlighting = true,
    },
  },
  gopls = {},
  pyright = {},
  rust_analyzer = {},
  tsserver = {},
  lua_ls = {
    Lua = {
      workspace = {
        library = vim.api.nvim_get_runtime_file('', true), -- Make the server aware of Neovim runtime files
        checkThirdParty = false,
      },
      telemetry = { enable = false },
    },
  }
}

require("mason-lspconfig").setup({ ensure_installed = vim.tbl_keys(servers) })

-- Show line diagnostics automatically in hover window
-- function on_attach, runs when LSP is connected {{{
local on_attach = function(client, bufnr)
  require "lsp_signature".on_attach({
    bind = true, -- This is mandatory, otherwise border config won't get registered.
    handler_opts = {
      border = "rounded"
    }
  }, bufnr)
  require('lsp-keymaps').register(client, bufnr)
end --}}}

-- autoconfig of lsps {{{
require("mason-lspconfig").setup_handlers({
  function(server_name) -- default handler (optional)
    require('lspconfig')[server_name].setup {
      on_attach = on_attach,
      capabilities = capabilities,
      settings = servers[server_name],
      handlers = {
        ["window/progress"] = function(params, client_id, bufnr, config)
          params.value.title = "[" .. params.value.kind .. "] " .. params.value.title
          vim.lsp.util.window_progress(params, client_id, bufnr, config)
        end,
      },
    }
  end,
}) -- }}}

-- TypeScript {{{
require("typescript").setup({
  server = {
    capabilities = capabilities,
    on_attach = function(client, bufnr)
      require("twoslash-queries").attach(client, bufnr)
      vim.keymap.set('n', "<C-k>", "<cmd>InspectTwoslashQueries<CR>", { buffer = bufnr })
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

null_ls.setup({
  sources = {
    null_ls.builtins.formatting.prettier,
  },
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
  end,
})


-- vi: fen fdl=0
