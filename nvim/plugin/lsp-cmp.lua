local setup = require "baggage"
    .from {
      "https://github.com/nvim-lua/plenary.nvim",
      'https://github.com/neovim/nvim-lspconfig',
      'https://github.com/marilari88/twoslash-queries.nvim',
      'https://github.com/williamboman/mason.nvim',
      "https://github.com/pmizio/typescript-tools.nvim",
    }

setup('mason', { -- {{{
  -- to create a list of all the configured servers in this file:
  -- read !rg '^lspconfig\.(\w+)\.' -o -r '"$1",' % | sort
  ensure_installed = {
    "clangd",
    "cssls",
    "cssmodules_ls",
    "denols",
    "eslint",
    "gopls",
    "lua_ls",
    "marksman",
    "pyright",
    "rust_analyzer",
    "sourcekit",
    "svelte",
    "tailwindcss",
  }
}) -- }}}

local lspconfig = require 'lspconfig'

local capabilities = require "baggage"
    .from 'https://github.com/hrsh7th/cmp-nvim-lsp'
    .load('cmp_nvim_lsp')
    .default_capabilities(vim.lsp.protocol.make_client_capabilities())

lspconfig.rust_analyzer.setup {}

lspconfig.pyright.setup {}

lspconfig.elixirls.setup {
  cmd = { "/Users/nilsriedemann/.local/share/nvim/mason/bin/elixir-ls" }
}

-- local lexical_config = {
--   filetypes = { "elixir", "eelixir", "heex" },
--   cmd = { "/Users/nilsriedemann/code/lexical/_build/dev/package/lexical/bin/start_lexical.sh" },
--   settings = {},
-- }
--
-- if not lspconfig.lexical then
--   lspconfig.lexical = {
--     default_config = {
--       filetypes = lexical_config.filetypes,
--       cmd = lexical_config.cmd,
--       root_dir = function(fname)
--         return lspconfig.util.root_pattern("mix.exs", ".git")(fname) or vim.loop.os_homedir()
--       end,
--       -- optional settings
--       settings = lexical_config.settings,
--     },
--   }
-- end

-- lspconfig.lexical.setup({
--   cmd = { "/Users/nilsriedemann/code/lexical/_build/dev/package/lexical/bin/start_lexical.sh" },
-- })

lspconfig.gopls.setup {}
lspconfig.marksman.setup {}


lspconfig.cssls.setup {
  settings = {
    css = { validate = true,
      lint = {
        unknownAtRules = "ignore"
      }
    },
  }
}

lspconfig.cssmodules_ls.setup {}

-- lspconfig.tailwindcss.setup { -- {{{
--   capabilities = capabilities,
--   init_options = {
--     userLanguages = {
--       eelixir = "html-eex",
--       eruby = "erb"
--     }
--   },
--   settings = {
--     tailwindCSS = {
--       editor = {
--         quickSuggestions = {
--           strings = "on"
--         }
--       }
--     }
--   }
-- }                        -- }}}

lspconfig.lua_ls.setup({ -- {{{
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
})                       ---}}}

lspconfig.clangd.setup({ -- {{{
  capabilities = capabilities,
  cmd = { "clangd", "--background-index", "--clang-tidy" --[[ , "--header-insertion=iwyu" ]] },
  init_options = {
    clangdFileStatus = true
  },
})                       -- }}}

lspconfig.denols.setup { -- {{{
  capabilities = capabilities,
  root_dir     = require('lspconfig.util').root_pattern("deno.json", "deno.jsonc"),
  cmd          = { "deno", "lsp" },
  init_options = {
    enable = true, unstable = true
  }
}                        -- }}}

lspconfig.svelte.setup { -- {{{
  capabilities = capabilities,
  root_dir     = require('lspconfig.util').root_pattern("svelte.config.js"),
} -- }}}

lspconfig.astro.setup {}
lspconfig.eslint.setup {}
-- lspconfig.tsserver.setup {}
lspconfig.biome.setup {}

require 'typescript-tools'.setup {
  capabilities = capabilities,
  single_file_support = false,
  root_dir = lspconfig.util.root_pattern({ "tsconfig.json", "package.json" }),
  on_attach = function(client, bufnr)
    require("twoslash-queries").attach(client, bufnr)
    local keyopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', '<leader>ci', ':TSToolsAddMissingImports<cr>', keyopts)
    vim.keymap.set('n', '<leader>co', ':TSToolsOrganizeImports<cr>', keyopts)
    vim.keymap.set('n', '<leader>cu', ':TSToolsRemoveUnused<cr>', keyopts)
    vim.keymap.set('n', '<leader>cA', ':TSToolsFixAll<cr>', keyopts)
    vim.keymap.set('n', '<leader>cR', ':TSToolsRenameFile<cr>', keyopts)
  end,
}

lspconfig.sourcekit.setup({                -- {{{
  capabilities = capabilities,
})                                         -- }}}

vim.api.nvim_create_autocmd('LspAttach', { -- {{{
  callback = function(args)
    local bufnr = args.buf
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    -- NOTE: usually checking if client_server_capabilities.completionProvider is
    -- true, but I want to see a proper error message if it's not, and not
    -- fallback to default (tag|omni)func
    vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"
    vim.bo.tagfunc = "v:lua.vim.lsp.tagfunc"
    vim.bo.formatexpr = "v:lua.vim.lsp.formatexpr()"

    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gK', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)

    vim.keymap.set('n', '<leader>j', vim.diagnostic.goto_next, bufopts)
    vim.keymap.set('n', '<leader>k', vim.diagnostic.goto_prev, bufopts)
    vim.keymap.set('n', "<leader>J",
      function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR }) end, bufopts)
    vim.keymap.set('n', "<leader>K",
      function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR }) end, bufopts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, bufopts)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, bufopts)
    vim.keymap.set('n', "]D", function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR }) end,
      bufopts)
    vim.keymap.set('n', "[D", function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR }) end,
      bufopts)

    vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, bufopts)
    vim.keymap.set('n', '<leader>q', ':Diagnostics<cr>', bufopts)
    vim.keymap.set('n', '<leader>Q', ':Diagnostics error<cr>', bufopts)

    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
      bufopts)
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)

    vim.keymap.set('n', 'gr', ':FzfLua lsp_references<CR>', bufopts)
    vim.keymap.set('n', 'gd', ':FzfLua lsp_definitions<CR>', bufopts)
    vim.keymap.set('n', 'gy', ':FzfLua lsp_type_definitions<cr>', bufopts)
    vim.keymap.set('n', 'gi', ':FzfLua lsp_type_implementations<cr>', bufopts)
    vim.keymap.set('n', 'gD', ':lua vim.lsp.buf.declaration<cr>', bufopts)

    vim.keymap.set('n', '<c-w>d', ':vs<cr>:lua vim.lsp.buf.definition()<cr>zt', bufopts)
    vim.keymap.set('n', '<c-w>D', ':vs<cr>:lua vim.lsp.buf.declaration()<cr>zt', bufopts)
    vim.keymap.set('n', '<c-w>t', ':vs<cr>:lua vim.lsp.buf.type_definition()<cr>zt', bufopts)
    vim.keymap.set('n', '<c-w>i', ':vs<cr>:lua vim.lsp.buf.implementation()<cr>zt', bufopts)
    vim.keymap.set('i', '<c-]>', vim.lsp.buf.signature_help)
  end
}) -- }}}

-- vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers['signature_help'], {
--   -- {{{
--   border = 'single',
--   close_events = { "CursorMoved", "BufHidden" },
-- }) -- }}}
