local null_ls = require('null-ls')

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

-- LSP Server Configuration {{{
local servers = {
  clangd = {
    capabilities = require('snock.lsp').capabilities(),
    cmd = { "clangd", "--background-index", "--clang-tidy" --[[ , "--header-insertion=iwyu" ]] },
    init_options = {
      clangdFileStatus = true
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
require("mason-lspconfig").setup({
  ensure_installed = vim.tbl_keys(servers)
})
-- }}}
-- Semi-automatic configuration of LSPs {{{
require("mason-lspconfig").setup_handlers({
  function(server_name) -- default handler (optional)
    require('lspconfig')[server_name].setup {
      on_attach = require("snock.lsp").on_attach,
      capabilities = require('snock.lsp').capabilities(),
      handlers = require('snock.lsp').handlers,
      settings = servers[server_name],
    }
  end,
}) -- }}}
-- TypeScript {{{
-- Using the plugin since it adds some useful commands
require("typescript").setup({
  server = {
    capabilities = require('snock.lsp').capabilities(),
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
-- Null-LS {{{
null_ls.setup({
  sources = {
    null_ls.builtins.formatting.prettier,
  },
  on_attach = require("snock.lsp").on_attach,
})
-- }}}

-- vi: fen fdl=0
