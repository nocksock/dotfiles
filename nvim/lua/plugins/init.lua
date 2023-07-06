return {
  { 'nvim-lua/plenary.nvim', lazy = true },
  { 'kkharji/sqlite.lua',    lazy = true },
  { 'numToStr/Comment.nvim', config = true, event = { "BufReadPost", "BufNewFile" } },
  {
    'nocksock/do.nvim',
    opts = { winbar = true },
    dev = true,
    event = "VeryLazy"
  },
  { 'nocksock/t.nvim',       dev = true,                             event = "VeryLazy" },
  { 'tpope/vim-eunuch',      event = "VeryLazy" },
  { 'tpope/vim-abolish',     event = { "BufReadPost", "BufNewFile" } },
  { 'tpope/vim-speeddating', event = { "BufReadPost", "BufNewFile" } },
  { 'tpope/vim-repeat',      event = { "BufReadPost", "BufNewFile" } },
  { 'mattn/emmet-vim',       event = { "BufReadPost", "BufNewFile" } },
  { 'tpope/vim-scriptease',  event = { "BufReadPost", "BufNewFile" } },
  {
    'ThePrimeagen/harpoon',
    keys = {
      { "<leader>'", ':lua require("harpoon.mark").add_file()<CR>' },
      { "''",        ':lua require("harpoon.ui").toggle_quick_menu()<CR>' },
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
  },
  {
    'junegunn/vim-easy-align',
    keys = {
      { 'ga', '<Plug>(EasyAlign)', mode = "x" },
      { 'ga', '<Plug>(EasyAlign)' },
    }
  },
  {
    'windwp/nvim-autopairs', -- nvim-autopairs: auto pairs in lua
    event = 'InsertEnter',
    opts = {
      disable_filetype = { "TelescopePrompt", "fennel" }
    }
  },
  { 'kyazdani42/nvim-web-devicons', lazy = true },
  {
    'folke/todo-comments.nvim',
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = false,
      highlight = { keyword = "" } -- using TreeSitter for highlights
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
  { 'folke/tokyonight.nvim',        event = "VeryLazy" },
  { 'rktjmp/lush.nvim',             event = "VeryLazy" },
  { 'nocksock/bloop.nvim',          dev = true,        event = "VeryLazy" },
  { 'nocksock/nazgul-vim',          dev = true,        event = "VeryLazy" },
  { 'nocksock/ghash.nvim',          dev = true,        event = "VeryLazy" },
  -- }}}
  -- completion {{{
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    config = function()
      require "configs.cmp";
    end,
    dependencies = {
      'hrsh7th/cmp-nvim-lsp', -- lsp source
      'hrsh7th/cmp-nvim-lua', -- neovim LUA Api source
      'hrsh7th/cmp-path',     -- path completions
      'hrsh7th/cmp-cmdline',  -- source for cmdline (:, /)
      'hrsh7th/cmp-buffer',   -- buffer source
      {
        'L3MON4D3/LuaSnip',   -- the first snippet plugin to beat UltiSnips for me?
      }
    }
  }, -- }}}
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
      { '<leader>hn', "<cmd>Gitsigns next_hunk<CR>" },
      { '<leader>hp', "<cmd>Gitsigns prev_hunk<CR>" },
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
    "VonHeikemen/lsp-zero.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      'rmagatti/goto-preview', -- open gotos in floating windows
      "neovim/nvim-lspconfig",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      'github/copilot.vim',
      'ray-x/lsp_signature.nvim', -- show function signatures from LSP when typing
      'folke/trouble.nvim',       -- pretty list for LSP diagnostics
    },
    config = function() require "configs.lsp" end
  },
  {
    'jose-elias-alvarez/typescript.nvim', -- more ts lsp stuff
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      { 'windwp/nvim-ts-autotag', opts = { update_on_insert = true } }, -- use TreeSitter to close and rename tags
      'jose-elias-alvarez/null-ls.nvim',                                -- use neovim as ls server to inject code-actions and mor via lua
      "lbrayner/vim-rzip",
      "marilari88/twoslash-queries.nvim",                               -- // ^?
    },
  },                                                                    -- }}}
  -- navigation {{{
  {
    'tpope/vim-vinegar', -- improved netrw for file browsing.
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
        '<leader>to', ':SymbolsOutline<cr>'
      }
    }
  }, {
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
    'folke/trouble.nvim', -- pretty list for LSP diagnostics
    keys = {
      { '<leader>xd', ':Trouble document_diagnostics<CR>' },
      { '<leader>xD', ':Trouble workspace_diagnostics<CR>' },
      { '<leader>xt', ':TodoTrouble<CR>' }
    }
  },
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
      { '<leader><cr>', ":Telescope resume<cr>" },
      { '<leader>T',    ":Telescope builtin<cr>" },
      { '<leader>/',    ':Telescope current_buffer_fuzzy_find<cr>' },
      { '<leader>f',    ":Telescope find_files hidden=true<cr>" },
      { '<c-p>',        ":Telescope find_files hidden=true<cr>" },
      { '<leader>b',    ":Telescope buffers<cr>" },
      { '<c-b>',        ":Telescope buffers<cr>" },
      { '<leader>sC',   ":Telescope colorscheme enable_preview=true<cr>" },
      { '<M-r>',        ':Telescope lsp_dynamic_workspace_symbols<cr>' },
      { '<leader>-',    ":Telescope file_browser path=%:p:h<cr>" },
      { '<leader>sr',   ":Telescope oldfiles<cr>" },
      { '<leader>sh',   ":Telescope help_tags<cr>" },
      { '<leader>sc',   ":Telescope commands<cr>" },
      { '<leader>*',    ":Telescope grep_string<cr>" },
      { '<leader>gb',   ":Telescope git_branches<cr>" },
      { '<leader>gs',   ':Telescope git_status<cr>' },
      { '<leader>sg',   ":lua require('telescope').extensions.live_grep_args.live_grep_args()<cr>", },
      { '<leader>sp',   ":lua R('snock.plugins.search-plugins'}.search(}<cr>" },
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
  {
    'junegunn/fzf',
    install = ':execute fzf#install()',
    event = 'VeryLazy',
    dependencies = {
      {
        'junegunn/fzf.vim',
        keys = {
          -- { '<c-/>', ':Lines<cr>'},
          -- { '<C-B>', ":Buffers<cr>"},
          -- { '<C-P>', ":Files<cr>"},
        }
      }
    }
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
        init = function()
          -- PERF: no need to load the plugin, if we only need its queries for mini.ai
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
        "hcl",
        "html",
        "http",
        "javascript",
        "json",
        "json5",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "php",
        "prisma",
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
        end, opts.ensure_installed)
      end
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
  { 'nvim-treesitter/nvim-treesitter-context', event = { "BufReadPost", "BufNewFile" } },
  { 'nvim-treesitter/playground',              event = { "BufReadPost", "BufNewFile" } },
  { 'kylechui/nvim-surround',                  config = true },
  -- }}}
  {
    'nvim-lualine/lualine.nvim',
    config = function()
      require('configs.lualine')
    end
  },
}
