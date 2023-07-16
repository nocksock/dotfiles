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
  { 'tpope/vim-eunuch',      event = "CmdlineEnter" },
  { 'tpope/vim-abolish',     event = { "BufReadPost", "BufNewFile" } },
  { 'tpope/vim-repeat',      event = { "BufReadPost", "BufNewFile" } },
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
      { '<leader>tu', ':MundoToggle<CR>' }
    }
  },
  -- colors {{{
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    event = "VeryLazy",
    priority = 1000,
    config = function()
      require("rose-pine").setup()
      vim.cmd('colorscheme rose-pine')
      vim.g.colors_name = 'rose-pine'
    end
  },
  { 'rktjmp/lush.nvim',      lazy = true },
  { 'nocksock/bloop.nvim',   dev = true,        event = "VeryLazy" },
  -- }}}
  -- completion {{{
  {
    'github/copilot.vim',
    event = 'InsertEnter',
  },
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    config = function()
      require "configs.cmp";
    end,
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-path',
    }
  },
  { 'SirVer/ultisnips', event = { "BufReadPost", "BufNewFile" }, },
  { 'mattn/emmet-vim', event = 'InsertEnter' },
  {
    'windwp/nvim-autopairs', -- nvim-autopairs: auto pairs in lua
    event = 'InsertEnter',
    opts = {
      disable_filetype = { "TelescopePrompt" }
    }
  },
  -- }}}
  -- filetree {{{
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
  -- git {{{
  {
    'tpope/vim-fugitive', -- a git wrapper in vim
    event = { "BufReadPost", "BufNewFile" },
    keys = {
      { '<leader>gg', ':tab G<cr>' },
      { '<leader>cc', ':Git commit<cr>' },
    }
  },
  {
    'lewis6991/gitsigns.nvim',
    event = { "BufReadPost", "BufNewFile" },
    keys = {
      -- local gitsigns = require('gitsigns.actions')
      { '[h', "<cmd>Gitsigns prev_hunk<CR>" },
      { ']h', "<cmd>Gitsigns next_hunk<CR>" },
      { '<leader>hs', function() require("gitsigns.actions").stage_hunk() end, },
      { '<leader>hs', function() require("gitsigns.actions").stage_hunk() end, },
      { '<leader>hr', function() require("gitsigns.actions").reset_hunk() end, },
      { '<leader>hr', function() require("gitsigns.actions").reset_hunk() end, },
      { '<leader>hu', function() require("gitsigns.actions").undo_stage_hunk() end, },
      { '<leader>hS', function() require("gitsigns.actions").stage_buffer() end, },
      { '<leader>hR', function() require("gitsigns.actions").reset_buffer() end, },
      { '<leader>hp', function() require("gitsigns.actions").preview_hunk() end, },
      { '<leader>hb', ':lua require"gitsigns".blame_line{full=true}<CR>', },
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
    -- lsp setup
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function() require "configs.lsp" end,
    dependencies = {
      "williamboman/mason.nvim", -- neat ui to handle installation of external lsp, linters, formatters etc. (install only, no configuration)
      'prettier/vim-prettier',
      "marilari88/twoslash-queries.nvim",   -- // ^?

      -- lsp convenienves
      'rmagatti/goto-preview',                -- open gotos in floating windows
      'ray-x/lsp_signature.nvim',             -- show function signatures from LSP when typing
      { 'folke/trouble.nvim', config = true }, -- pretty list for LSP diagnostics
    },
  }, -- }}}
  -- navigation {{{
  {
    'tpope/vim-vinegar', -- improved netrw for file browsing.
    event = 'VeryLazy',
  },
  {
    'ThePrimeagen/harpoon',
    keys = {
      { "<leader>'", ':lua require("harpoon.mark").add_file()<CR>' },
      { "''",        ':lua require("harpoon.ui").toggle_quick_menu()<CR>' },
      { "'f",        ':lua require("harpoon.ui").nav_file(1)<CR>' },
      { "'d",        ':lua require("harpoon.ui").nav_file(2)<CR>' },
      { "'s",        ':lua require("harpoon.ui").nav_file(3)<CR>' },
      { "'a",        ':lua require("harpoon.ui").nav_file(4)<CR>' }
    },
    opts = {
      global_settings = {
        enter_on_sendcmd = true
      }
    }
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
        '<leader>to', ':SymbolsOutline<cr>'
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
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-live-grep-args.nvim",
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make', },
      "nvim-telescope/telescope-ui-select.nvim"
    },
    cmd = { "Telescope" },
    -- stylua: ignore
    keys = {
      { '<M-r>',        ':Telescope lsp_dynamic_workspace_symbols<cr>' },
      { '<c-b>',        ':Telescope buffers<cr>' },
      { '<c-p>',        ':Telescope find_files hidden=true<cr>' },
      { '<leader>*',    ':Telescope grep_string<cr>' },
      { '<leader>/',    ':Telescope current_buffer_fuzzy_find<cr>' },
      { '<leader><cr>', ':Telescope resume<cr>' },
      { '<leader>T',    ':Telescope builtin<cr>' },
      { '<leader>gb',   ':Telescope git_branches<cr>' },
      { '<leader>gs',   ':Telescope git_status<cr>' },
      { '<leader>sc',   ':Telescope commands<cr>' },
      { '<leader>sC',   ':Telescope colorscheme enable_preview=true<cr>' },
      { '<leader>sb',   ':Telescope buffers<cr>' },
      { '<leader>ss',   ':Telescope lsp_document_symbols<cr>' },
      { '<leader>sS',   ':Telescope lsp_dynamic_workspace_symbols<cr>' },
      { '<leader>sf',   ':Telescope find_files hidden=true<cr>' },
      { '<leader>sg',   ':lua require("telescope").extensions.live_grep_args.live_grep_args()<cr>', },
      { '<leader>sh',   ':Telescope help_tags<cr>' },
      { '<leader>sr',   ':Telescope oldfiles<cr>' },
    },
    config = function()
      local telescope = require('telescope')
      telescope.load_extension('fzf')
      telescope.load_extension("live_grep_args")
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
  -- treesitter{{{
  {
    "nvim-treesitter/nvim-treesitter",
    version = false, -- last release is way too old and doesn't work on Windows
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter-textobjects",
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
    event = "VeryLazy",
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
  { 'nocksock/t.nvim',              dev = true, event = "VeryLazy", config = true },
  { 'nvim-lua/plenary.nvim',        lazy = true },
  { 'kyazdani42/nvim-web-devicons', lazy = true },
}
