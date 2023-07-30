return {
  -- basic
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
      require('Comment.ft').set('jq', '#%s')
    end,
    event = { "BufReadPost", "BufNewFile" }
  },
  { 'tpope/vim-eunuch',  event = "CmdlineEnter" },
  { 'tpope/vim-abolish', event = { "BufReadPost", "BufNewFile" } },
  { 'tpope/vim-repeat',  event = { "BufReadPost", "BufNewFile" } },
  {
    'junegunn/vim-easy-align',
    keys = {
      { 'ga', '<Plug>(EasyAlign)', mode = "x" },
      { 'ga', '<Plug>(EasyAlign)' },
    }
  },
  {
    'simnalamburt/vim-mundo',
    keys = {
      { '<leader>tu', '<cmd>MundoToggle<CR>' }
    }
  },
  -- colors {{{
  {
    'catppuccin/nvim',
    event = "VeryLazy",
  },
  { 'EdenEast/nightfox.nvim', event = "VeryLazy" },
  { 'cocopon/iceberg.vim',    event = "VeryLazy" },
  { 'folke/tokyonight.nvim',  event = "VeryLazy" },
  { 'w0ng/vim-hybrid',        event = "VeryLazy" },
  { 'wadackel/vim-dogrun',    event = "VeryLazy" },
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    priority = 1000,
    config = function()
      require("rose-pine").setup()
      vim.g.colors_name = 'rose-pine'
      vim.o.background = vim.system({ 'is-dark-mode' }):wait().stdout == '1\n' and 'dark' or 'light'
    end
  },
  { 'rktjmp/lush.nvim',    lazy = true },
  { 'nocksock/bloop.nvim', dev = true,            event = "VeryLazy" },
  -- }}}
  -- completion {{{
  { 'github/copilot.vim',  event = 'InsertEnter', },
  {
    'hrsh7th/nvim-cmp', -- {{{
    event = 'InsertEnter',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-path',
    },
    config = function()
      local cmp = require('cmp')
      cmp.setup({
        snippet = {
          expand = function(args)
            vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
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
              ['<c-l>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.complete_common_string()
            else
              fallback()
            end
          end, { 'i' }),
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
          { name = 'nvim_lsp' },
        }, {
          { name = 'path' }
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
    end, -- }}}
  },
  { 'SirVer/ultisnips', event = { "BufReadPost", "BufNewFile" }, },
  { 'mattn/emmet-vim',  event = 'InsertEnter' },
  {
    'windwp/nvim-autopairs', -- nvim-autopairs: auto pairs in lua
    event = 'InsertEnter',
    opts = {
      disable_filetype = { "TelescopePrompt" }
    }
  },
  -- }}}
  -- filetree {{{
  -- currently evaluating which i prefer.
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    opts = {
      filesystem = {
        hijack_netrw_behavior = 'disabled',
      },
      window = {
        position = "right",
        mappings = {
              ["Z"] = "expand_all_nodes",
        }
      },
    }
  },
  {
    'kyazdani42/nvim-tree.lua',
    keys = {
      { '<leader>tt', '<cmd>NvimTreeToggle<cr>' },
    },
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      hijack_cursor = true,
      hijack_netrw = false,
      view = {
        preserve_window_proportions = true,
        side = "right",
        centralize_selection = true
      },
      diagnostics = {
        enable = true
      },
      renderer = {
        icons = {
          git_placement = "after"
        }
      },
      actions = {
        change_dir = {
          enable = false
        },
        expand_all = {
          exclude = { ".git", "node_modules" }
        }
      }
    }
  }, -- }}}
  -- git {{{
  {
    'tpope/vim-fugitive', -- a git wrapper in vim
    event = { "BufReadPost", "BufNewFile" },
  },
  {
    'lewis6991/gitsigns.nvim',
    event = { "BufReadPost", "BufNewFile" },
    keys = {
      -- local gitsigns = require('gitsigns.actions')
      { '[h',         "<cmd>Gitsigns prev_hunk<CR>" },
      { ']h',         "<cmd>Gitsigns next_hunk<CR>" },
      { '<leader>hs', function() require("gitsigns.actions").stage_hunk() end, },
      { '<leader>hs', function() require("gitsigns.actions").stage_hunk() end, },
      { '<leader>hr', function() require("gitsigns.actions").reset_hunk() end, },
      { '<leader>hr', function() require("gitsigns.actions").reset_hunk() end, },
      { '<leader>hu', function() require("gitsigns.actions").undo_stage_hunk() end, },
      { '<leader>hS', function() require("gitsigns.actions").stage_buffer() end, },
      { '<leader>hR', function() require("gitsigns.actions").reset_buffer() end, },
      { '<leader>hp', function() require("gitsigns.actions").preview_hunk() end, },
      { '<leader>hb', '<cmd>lua require"gitsigns".blame_line{full=true}<CR>', },
      { '<leader>hd', function() require("gitsigns.actions").diffthis() end, },
      { '<leader>hD', function() require "gitsigns".diffthis("~") end, },
      {
        'ic',
        function() require("gitsigns.actions").select_hunk() end,
        mode = "o",
      },
      {
        'ic',
        function() require("gitsigns.actions").select_hunk() end,
        mode = "x",
      },
    },
    config = true
  }, -- }}}
  -- lspconfig {{{
  {
    "williamboman/mason.nvim", -- neat ui to handle installation of external lsp, linters, formatters etc. (install only, no configuration)
    event = 'VeryLazy'
  },
  {
    -- LSP setup
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function() require "configs.lsp" end,
    dependencies = {
      'prettier/vim-prettier',
      "marilari88/twoslash-queries.nvim",   -- // ^?
      'jose-elias-alvarez/typescript.nvim', -- TS conveniences

      -- LSP conveniences
      'rmagatti/goto-preview', -- open gotos in floating windows
      { 'folke/trouble.nvim', config = true }, -- pretty list for LSP diagnostics
    },
  },                                           -- }}}
  -- navigation {{{
  {
    'ThePrimeagen/harpoon',
    keys = {
      { "<leader>'", '<cmd>lua require("harpoon.mark").add_file()<CR>' },
      { "''",        ':lua require("harpoon.ui").toggle_quick_menu()<CR>' },
      { "<leader>;;", '<cmd>lua lua require("harpoon.cmd-ui").toggle_quick_menu()'},
      { "<leader>;f", '<cmd>lua require("harpoon.term").gotoTerminal(1)'},
      { "'f",        ':lua require("harpoon.ui").nav_file(1)<CR>' }, -- alt + j
      { "'d",        ':lua require("harpoon.ui").nav_file(2)<CR>' }, -- alt + k
      { "'s",        ':lua require("harpoon.ui").nav_file(3)<CR>' }, -- alt + l
      { "'a",        ':lua require("harpoon.ui").nav_file(4)<CR>' }  -- alt + ;
    },
    opts = {
      global_settings = {
        enter_on_sendcmd = true
      }
    }
  }, {
  'tpope/vim-vinegar',   -- improved netrw for file browsing.
  event = 'VeryLazy',
},
  {
    'mcchrish/nnn.vim', -- using nnn in a floating window (and open file in vim)
    event = 'VeryLazy',
  },
  {
    'christoomey/vim-tmux-navigator',
    event = "VeryLazy"
  },
  {
    'simrat39/symbols-outline.nvim', -- treeview for symbols in current buf
    keys = {
      {
        '<leader>to', '<cmd>SymbolsOutline<cr>'
      }
    },
    config = true
  },
  {
    'kyazdani42/nvim-tree.lua',
    keys = {
      { '<leader>tt', function() require("nvim-tree.api").tree.toggle() end }
    },
    opts = {
      hijack_cursor = true,
      hijack_netrw = false,
      view = {
        preserve_window_proportions = true,
        side = "right",
        centralize_selection = true
      },
      diagnostics = {
        enable = true
      },
      renderer = {
        icons = {
          git_placement = "after"
        }
      },
      actions = {
        change_dir = {
          enable = false
        },
        expand_all = {
          exclude = { ".git", "node_modules" }
        }
      }
    }
  }, -- }}}
  -- search {{{
  {
    'junegunn/fzf.vim',
    event = 'VeryLazy',
    dependencies = {
      'junegunn/fzf',
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make', },
      "nvim-telescope/telescope-ui-select.nvim"
    },
    cmd = { "Telescope" },
    -- stylua: ignore
    keys = {
      { '<leader>f',        '<cmd>Telescope find_files<cr>' },
      { '<leader>F',        '<cmd>Telescope find_files hidden=true cwd=%<cmd>p<cmd>h<cr>' },
      { '<leader>*',        '<cmd>Telescope grep_string<cr>' },
      { '<leader>/',        '<cmd>Telescope live_grep<cr>', },
      { '<leader>?',        '<cmd>Telescope live_grep cwd=%<cmd>p<cmd>h<cr>', },
      { '<leader><cmd>',        '<cmd>Telescope commands<cr>' },
      { '<leader>;',        '<cmd>Telescope command_history<cr>' },
      { '<leader><cr>',     '<cmd>Telescope resume<cr>' },
      { '<leader>h',        '<cmd>Telescope help_tags<cr>' },
      { '<leader>S',        '<cmd>Telescope lsp_dynamic_workspace_symbols<cr>' },
      { '<leader><leader>', '<cmd>Telescope buffers<cr>' },
      { '<leader>s',        '<cmd>Telescope lsp_document_symbols<cr>' },
      { '<leader>C',        '<cmd>Telescope colorscheme enable_preview=true<cr>' },
      { '<leader>T',        '<cmd>Telescope builtin<cr>' },
      { '<leader>l',        '<cmd>Telescope current_buffer_fuzzy_find<cr>' },
    },
    config = function()
      local telescope = require('telescope')
      telescope.load_extension('fzf')
      telescope.load_extension("ui-select")
      telescope.setup({
        defaults = {
          mappings = {
            i = {
                  ['<C-E>'] = "insert_symbol",
                  ['<C-q>'] = 'send_selected_to_qflist',
                  ['<C-a>'] = 'add_selected_to_qflist',
                  ["<c-space>"] = function(prompt_bufnr)
                require("telescope.actions.generate").refine(prompt_bufnr, {
                  prompt_to_prefix = true,
                  sorter = false,
                })
              end,
            },
            n = {
                  ['<Down>'] = "cycle_history_next",
                  ['<Up>'] = "cycle_history_prev",
            }
          },
          layout_strategy = 'vertical',
        },
        pickers = {
          buffers = {
            sort_lastused = true,
            path_display = { "smart" },
            mappings = {
              n = {
                    ["dd"] = "delete_buffer"
              }
            }
          }
        },
        extensions = {
          fzf = {
            fuzzy = true,                   -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true,    -- override the file sorter
          },
        },
      })
    end,
  },
  -- }}}
  -- treesitter {{{
  {
    "nvim-treesitter/nvim-treesitter",
    version = false, -- last release is way too old and doesn't work on Windows
    build = "<cmd>TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      {
        {
          "nvim-treesitter/nvim-treesitter-textobjects",
          config = function()
            require("nvim-treesitter.configs").setup {
              textobjects = {
                select = {
                  enable = true,
                  -- Automatically jump forward to textobj, similar to targets.vim
                  lookahead = true,
                  keymaps = {
                    -- You can use the capture groups defined in textobjects.scm
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",
                        ["ac"] = "@class.outer",
                    -- You can optionally set descriptions to the mappings (used in the desc parameter of
                    -- nvim_buf_set_keymap) which plugins like which-key display
                        ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
                    -- You can also use captures from other query groups like `locals.scm`
                        ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
                  },
                  -- You can choose the select mode (default is charwise 'v')
                  --
                  -- Can also be a function which gets passed a table with the keys
                  -- * query_string: eg '@function.inner'
                  -- * method: eg 'v' or 'o'
                  -- and should return the mode ('v', 'V', or '<c-v>') or a table
                  -- mapping query_strings to modes.
                  selection_modes = {
                        ['@parameter.outer'] = 'v', -- charwise
                        ['@function.outer'] = 'V', -- linewise
                        ['@class.outer'] = '<c-v>', -- blockwise
                  },
                  -- If you set this to `true` (default is `false`) then any textobject is
                  -- extended to include preceding or succeeding whitespace. Succeeding
                  -- whitespace has priority in order to act similarly to eg the built-in
                  -- `ap`.
                  --
                  -- Can also be a function which gets passed a table with the keys
                  -- * query_string: eg '@function.inner'
                  -- * selection_mode: eg 'v'
                  -- and should return true of false
                  include_surrounding_whitespace = true,
                },
              },
            }
          end
        },
        'windwp/nvim-ts-autotag',
        opts = { update_on_insert = true }, -- use TreeSitter to close and rename tags
        init = function()
          local plugin = require("lazy.core.config").spec.plugins["nvim-treesitter"]
          local opts = require("lazy.core.plugin").values(plugin, "opts", false)
          local enabled = false
          if opts.textobjects then
            for _, mod in ipairs({ "move", "select", "swap", "lsp_interop" }) do
              if opts.textobjects[mod] and opts.textobjects[mod].enable then
                enabled = true
                break
              end
            end
          end
          if not enabled then
            require("lazy.core.loader").disable_rtp_plugin("nvim-treesitter-textobjects")
          end
        end,
      },
    },
    keys = {
      { "<c-space>" },
      { "<bs>",     mode = "x" },
    },
    ---@type TSConfig
    opts = {
      highlight = { enable = true },
      indent = { enable = true },
      context_commentstring = { enable = true, enable_autocmd = false },
      ensure_installed = {
        "astro",
        "bash",
        "c",
        "comment",
        "fennel",
        "go",
        "html",
        "javascript",
        "json",
        "json5",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "yaml",
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
    },
    ---@param opts TSConfig
    config = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        ---@type table<string, boolean>
        local added = {}
        opts.ensure_installed = vim.tbl_filter(function(lang)
          if added[lang] then
            return false
          end
          added[lang] = true
          return true
          ---@diagnostic disable-next-line: param-type-mismatch
        end, opts.ensure_installed)
      end
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
  { 'nvim-treesitter/nvim-treesitter-context', event = { "BufReadPost", "BufNewFile" } },
  { 'nvim-treesitter/playground',              event = { "BufReadPost", "BufNewFile" } },
  { 'kylechui/nvim-surround',                  event = { "VeryLazy" },                 config = true },
  -- }}}
  {
    'nvim-lualine/lualine.nvim',
    config = function()
      require('configs.lualine')
    end
  },
  {
    'nocksock/do.nvim',
    opts = { winbar = true },
    dev = true,
    event = "VeryLazy"
  },
  { 'nocksock/t.nvim',              dev = true,                             event = "VeryLazy", config = true },
  { 'nvim-lua/plenary.nvim',        lazy = true },
  { 'kyazdani42/nvim-web-devicons', lazy = true },
  { 'tpope/vim-scriptease',         event = { "BufReadPost", "BufNewFile" } },
  -- {
  --   "folke/noice.nvim",
  --   event = "VeryLazy",
  --   opts = {
  --     -- add any options here
  --     --
  --     lsp = {
  --       -- override markdown rendering so that cmp and other plugins use Treesitter
  --       override = {
  --             ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
  --             ["vim.lsp.util.stylize_markdown"] = true,
  --             ["cmp.entry.get_documentation"] = true,
  --       },
  --     },
  --     -- you can enable a preset for easier configuration
  --     presets = {
  --       bottom_search = true,         -- use a classic bottom cmdline for search
  --       command_palette = true,       -- position the cmdline and popupmenu together
  --       long_message_to_split = true, -- long messages will be sent to a split
  --       inc_rename = false,           -- enables an input dialog for inc-rename.nvim
  --       lsp_doc_border = false,       -- add a border to hover docs and signature help
  --     },
  --     routes = {
  --       {
  --         filter = {
  --           event = "msg_show",
  --           kind = "",
  --           find = "written",
  --         },
  --         opts = { skip = true },
  --       },
  --     }
  --   },
  --   dependencies = {
  --     -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
  --     "MunifTanjim/nui.nvim",
  --     -- OPTIONAL:
  --     --   `nvim-notify` is only needed, if you want to use the notification view.
  --     --   If not available, we use `mini` as the fallback
  --     -- "rcarriga/nvim-notify",
  --   }
  -- }
}
