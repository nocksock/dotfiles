vim.api.nvim_create_autocmd("InsertEnter", {
  callback = function()
    vim.cmd([[
      packadd! nvim-lspconfig

      packadd! nvim-cmp
      packadd! cmp-buffer
      packadd! cmp-cmdline
      packadd! cmp-nvim-lua
      packadd! cmp-nvim-lsp
      packadd! cmp-path

      packadd! twoslash-queries.nvim
      packadd! typescript.nvim
    ]]);

    local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
    local lspconfig = require('lspconfig')

    lspconfig.rust_analyzer.setup {}

    lspconfig.pyright.setup {}

    lspconfig.gopls.setup {}

    lspconfig.marksman.setup {}

    lspconfig.eslint.setup {}

    lspconfig.cssls.setup {}

    lspconfig.cssmodules_ls.setup {}

    lspconfig.tailwindcss.setup { -- {{{
      capabilities = capabilities,
      settings = {
        tailwindCSS = {
          editor = {
            quickSuggestions = {
              strings = "on"
            }
          }
        }
      }
    } -- }}}

    -- Lua {{{
    lspconfig.lua_ls.setup({
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
                         -- {{{
      capabilities = capabilities,
      cmd = { "clangd", "--background-index", "--clang-tidy" --[[ , "--header-insertion=iwyu" ]] },
      init_options = {
        clangdFileStatus = true
      },
    })                   -- }}}

    lspconfig.denols.setup { -- {{{
      capabilities = capabilities,
      root_dir     = require('lspconfig.util').root_pattern("deno.json", "deno.jsonc"),
      cmd          = { "deno", "lsp" },
      init_options = {
        enable = true, unstable = true
      }
    }                    -- }}}

    lspconfig.svelte.setup { -- {{{
      capabilities = capabilities,
      root_dir     = require('lspconfig.util').root_pattern("svelte.config.js"),
    } -- }}}

    require("typescript").setup({
      -- {{{
      -- Using the plugin since it adds some useful commands,
      -- NOTE: afaik will be archived soon - but I'll keep using it until it's not working and then migrate
      server = {
        capabilities = capabilities,
        single_file_support = false,
        root_dir = lspconfig.util.root_pattern("package.json"),
        on_attach = function(client, bufnr)
          local keyopts = { noremap = true, silent = true, buffer = bufnr }
          require("twoslash-queries").attach(client, bufnr)

          vim.keymap.set('n', "<leader>it", "<cmd>InspectTwoslashQueries<CR>", keyopts)
          vim.keymap.set('n', '<leader>ci', ':TypescriptAddMissingImports<cr>', keyopts)
          vim.keymap.set('n', '<leader>co', ':TypescriptOrganizeImports<cr>', keyopts)
          vim.keymap.set('n', '<leader>cu', ':TypescriptRemoveUnused<cr>', keyopts)
          vim.keymap.set('n', '<leader>cA',
            ':TypescriptAddMissingImports<cr>:TypescriptAddMissingImports<CR>:TypescriptRemoveUnused<CR>', keyopts)
          vim.keymap.set('n', '<leader>cR', ':TypescriptRenameFile<cr>', keyopts)
        end,
      }
    })
    --}}}

    lspconfig.sourcekit.setup({ -- {{{
      capabilities = capabilities,
    })                      -- }}}

    vim.api.nvim_create_autocmd('LspAttach', {
      -- {{{
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

        vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, bufopts)
        vim.keymap.set('n', 'gd', ':lua vim.lsp.buf.definition()<cr>zt', bufopts)
        vim.keymap.set('n', 'gy', ':lua vim.lsp.buf.type_definition()<cr>zt', bufopts)
        vim.keymap.set('n', 'gi', ':lua vim.lsp.buf.implementation()<cr>zt', bufopts)
        vim.keymap.set('n', 'gD', ':lua vim.lsp.buf.declaration()<cr>zt', bufopts)

        vim.keymap.set('n', '<c-w>d', ':vs<cr>:lua vim.lsp.buf.definition()<cr>zt', bufopts)
        vim.keymap.set('n', '<c-w>D', ':vs<cr>:lua vim.lsp.buf.declaration()<cr>zt', bufopts)
        vim.keymap.set('n', '<c-w>t', ':vs<cr>:lua vim.lsp.buf.type_definition()<cr>zt', bufopts)
        vim.keymap.set('n', '<c-w>i', ':vs<cr>:lua vim.lsp.buf.implementation()<cr>zt', bufopts)
        vim.keymap.set('i', '<c-]>', vim.lsp.buf.signature_help)
      end
    }) -- }}}

    vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers['signature_help'], {
      -- {{{
      border = 'single',
      close_events = { "CursorMoved", "BufHidden" },
    }) -- }}}

    -- vi: fen fdl=0 fdm=marker fmr={{{,}}} fdc=3
    --
  end
, group = group });

vim.api.nvim_create_autocmd("InsertEnter", {
  group = group,
  callback = function() 
    local cmp = require('cmp')

    cmp.setup({
      snippet = {
        expand = function(args)
          require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        end,
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      mapping = cmp.mapping.preset.insert({
            ['<C-u>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
            ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
            ['<CR>'] = cmp.mapping.confirm({ select = false }),
            ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
            ['<C-e>'] = cmp.mapping({
          i = cmp.mapping.abort(),
          c = cmp.mapping.close(),
        }),
        --     ['<c-l>'] = cmp.mapping(function(fallback)
        --   if cmp.visible() then
        --     cmp.complete_common_string()
        --   else
        --     fallback()
        --   end
        -- end, { 'i' }),
            ['<c-n>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          else
            fallback()
          end
        end, { 'i', 'c' }),
            ['<c-p>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          else
            fallback()
          end
        end, { 'i', 'c' }),
      }),
      sources = cmp.config.sources({
        { name = "luasnip" },
        { name = "nvim_lsp" },
        { name = "path" },
      }, {
        { name = "copilot" },
        { name = "buffer" }
      }),
    })

    cmp.setup.filetype('gitcommit', {
      sources = cmp.config.sources({
        { name = 'path' },
      }),
    })

    cmp.setup.cmdline(':', {
      sources = cmp.config.sources({
        { name = 'cmdline' },
      }, {
        { name = 'buffer' },
        { name = 'path' },
      }),
    })
  end
})
