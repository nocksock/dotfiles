return {
  -- core utils {{{
  'nvim-lua/plenary.nvim', -- nvim-lua/plenary.nvim util functions. a dependency of many plugins
  'kkharji/sqlite.lua', -- sqlite client in lua that some plugins use
  { 'lewis6991/gitsigns.nvim', config = true }, -- }}}
  -- }}}
  -- general purpose tools {{{
  { 'numToStr/Comment.nvim',   config = true },
  'tpope/vim-abolish', -- working with words (drastic understatement)
  'tpope/vim-repeat', -- makes `.` even more powerful by adding support for plugins
  'mattn/emmet-vim', -- div.emmet>p.is{awesome}
  'tpope/vim-scriptease', -- helper commands useful when writing vim scripts etc
  'theprimeagen/refactoring.nvim', -- Treesitter powered refactorings
  -- navigating to important files and commands at ludicrous speed
  {
    'ThePrimeagen/harpoon',
    opts = {
      global_settings = {
        enter_on_sendcmd = true
      }
    }
  },

  'junegunn/vim-easy-align',
  { 'kylechui/nvim-surround', config = true }, -- replacement of vim-surround with some neat features like `dsf` powered by TreeSitter
  -- }}}
  -- telescope
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-live-grep-args.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make', },
    },
    config = function() require "configs.telescope" end
  },


  -- lsp and Autocompletion stuff {{{
  {
    "VonHeikemen/lsp-zero.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",

      'hrsh7th/nvim-cmp',
      'hrsh7th/cmp-nvim-lsp', -- lsp source
      'hrsh7th/cmp-nvim-lua', -- neovim LUA Api source
      'hrsh7th/cmp-path', -- path completions
      'hrsh7th/cmp-cmdline', -- source for cmdline (:, /)
      'hrsh7th/cmp-buffer', -- buffer source

      'L3MON4D3/LuaSnip', -- the first snippet plugin to beat UltiSnips for me?
      { 'j-hui/fidget.nvim', config = true }, -- fidget.nvim: ui for nvm-lsp progress
      'github/copilot.vim',
      'ray-x/lsp_signature.nvim', -- show function signatures from LSP when typing
      'folke/trouble.nvim', -- pretty list for LSP diagnostics

      -- nvim-autopairs: auto pairs in lua
      {
        'windwp/nvim-autopairs',
        opts = {
          disable_filetype = { "TelescopePrompt", "fennel" }
        }
      },
    },
    config = function() require "configs.lsp" end
  },
  {
    'jose-elias-alvarez/typescript.nvim', -- more ts lsp stuff
    dependencies = {
      { 'windwp/nvim-ts-autotag', opts = { update_on_insert = true } }, -- use TreeSitter to close and rename tags
      'jose-elias-alvarez/null-ls.nvim', -- use neovim as ls server to inject code-actions and mor via lua
      "lbrayner/vim-rzip",
      "marilari88/twoslash-queries.nvim", -- // ^?
    },
  },
  -- }}}
  -- treesitter {{{
  {
    'nvim-treesitter/nvim-treesitter',
    config = function() require('configs.treesitter') end
  },
  'nvim-treesitter/playground', -- visual representation and query playground for the AST of TS
  'nvim-treesitter/nvim-treesitter-textobjects', -- create additional textobjects via TreeSitter (eg `if` => `@function.inner`)
  -- }}}
  -- git things {{{
  'tpope/vim-fugitive', -- a git wrapper in vim

  -- debugging {{{
  'mfussenegger/nvim-dap', -- DAP client
  'rcarriga/nvim-dap-ui', -- DAP UI
  'leoluz/nvim-dap-go', -- DAP Adapter for Go
  -- }}}
  -- UI {{{
  -- distraction free writing and some other nice things
  {
    'folke/zen-mode.nvim',
    opts = {
      plugins = {
        kitty = {
          enabled = true,
          font = '+4',
        },
        twilight = {
          enabled = true,
        },
        tmux = {
          enabled = false,
        },
        gitsigns = {
          enabled = true,
        },
        options = {
          enabled = true,
          showcmd = true,
        },
      },
      window = {
        backdrop = 0.95,
        width = 120,
        options = {
          signcolumn = 'yes',
          number = true,
          relativenumber = true,
          list = false,
        },
      },
    }
  }, -- }}}
  {
    'folke/twilight.nvim', -- highlight only portion of text
    opts = {
      inactive = true,
      context = 0, -- amount of lines we will try to show around the current line
      expand = {
        "function", "method", "if_statement", "table"
      }
    }
  }, -- }}}
  'rmagatti/goto-preview', -- open gotos in floating windows
  {
    'folke/which-key.nvim', -- show possible keys when nvim is waiting for a key press
    opts = {
      window = {
        border = 'double',
        position = 'center',
        margin = { 4, 4, 4, 6 }
      }
    }
  },
  {
    'nvim-lualine/lualine.nvim', -- lualine.nvim: easy to configure and extend statusline (+tabline, +windowline) {{{
    config = function() require "configs.lualine" end
  },
  'kyazdani42/nvim-web-devicons', -- bunch of icons for web development
  {
    'kyazdani42/nvim-tree.lua',
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
  },
  'nvim-treesitter/nvim-treesitter-context', -- sticky header
  'simrat39/symbols-outline.nvim', -- treeview for symbols in current buf
  {
    'folke/todo-comments.nvim', -- easy configurable todo search in comment with support for Trouble
    opts = {
      signs = false,
      highlight = { keyword = "" } -- using TreeSitter for highlights
    }
  }, -- }}}
  'simnalamburt/vim-mundo', -- browser for vim's undo tree, for when git is not enough
  'rktjmp/lush.nvim', -- for easily creating colorschemes via DSL
  'folke/tokyonight.nvim',
  { 'nocksock/bloop.nvim' , dev = true, },
  { 'nocksock/nazgul-vim' , dev = true, },
  { 'nocksock/ghash.nvim' , dev = true, },
  { 'nocksock/do.nvim'    , opts = { winbar = true }, dev = true },
  { 'nocksock/t.nvim'     , dev= true }, -- t.nvim: tiny term-toggle plugin
  'tpope/vim-eunuch', -- vim sugar for the unix shell commands that need it the most. Like :delete, :move, :chmod
  'tpope/vim-vinegar', -- improved netrw for file browsing.
  'mcchrish/nnn.vim', -- using nnn in a floating window (and open file in vim)
}
