local utils = require('snock.utils.plugins')
local use_local = utils.use_local
local conf = utils.conf

-- make sure packer is installed {{{
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
  vim.cmd [[packadd packer.nvim]]
end
--}}}
--
require('packer').startup({ function(use)
  -- core utils {{{
  use('https://github.com/wbthomason/packer.nvim') -- packer can manage itself
  use('nvim-lua/plenary.nvim') -- https://github.com/nvim-lua/plenary.nvim util functions. a dependency of many plugins
  use('https://github.com/kkharji/sqlite.lua') -- sqlite client in lua that some plugins use
  -- }}}
  -- general purpose tools {{{
  use({ 'https://github.com/numToStr/Comment.nvim', config = function()
    -- comments, with more smartness
    require('comment').setup {}
  end })
  use('https://github.com/tpope/vim-abolish') -- working with words (drastic understatement)
  use('https://github.com/tpope/vim-repeat') -- makes `.` even more powerful by adding support for plugins
  use('https://github.com/mattn/emmet-vim') -- div.emmet>p.is{awesome}
  use('https://github.com/tpope/vim-scriptease') -- helper commands useful when writing vim scripts etc
  use('https://github.com/theprimeagen/refactoring.nvim') -- Treesitter powered refactorings
  -- navigating to important files and commands at ludicrous speed
  use_local({
    'ThePrimeagen/harpoon',
    local_path = 'forks',
    config = function()
      require('harpoon').setup({
        global_settings = {
          enter_on_sendcmd = true
        }
      })
    end
  })

  use('https://github.com/junegunn/vim-easy-align')

  -- use('https://github.com/tpope/vim-surround') -- quoting/parenthesizing made simple. Extends functionality of s
  use({ 'https://github.com/kylechui/nvim-surround', config = function()
    -- replacement of vim-surround with some neat features like `dsf` powered by TreeSitter
    require("nvim-surround").setup()
  end })
  -- }}}
  -- telescope  {{{
  use {
    "nvim-telescope/telescope.nvim",
    requires = {
      { "nvim-telescope/telescope-live-grep-args.nvim" },
      { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    },
    config = function()
      require "snock.plugins.telescope"
    end
  }
  -- }}}
  -- lsp stuff {{{
  use {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  }

  use('jose-elias-alvarez/null-ls.nvim') -- use neovim as ls server to inject code-actions and mor via lua
  use('jose-elias-alvarez/typescript.nvim') -- more ts lsp stuff
  use('folke/trouble.nvim') -- pretty list for LSP diagnostics
  use('ray-x/lsp_signature.nvim') -- show function signatures from LSP when typing
  -- }}}
  -- treesitter {{{
  use({ 'https://github.com/nvim-treesitter/nvim-treesitter',
    -- simple API for treesitter for configuration and interactions
    commit = "4cccb6f494eb255b32a290d37c35ca12584c74d0"
  }) 
  use('https://github.com/nvim-treesitter/playground') -- visual representation and query playground for the AST of TS
  use('https://github.com/nvim-treesitter/nvim-treesitter-textobjects') -- create additional textobjects via TreeSitter (eg `if` => `@function.inner`)
  -- }}}
  -- git things {{{
  use('https://github.com/tpope/vim-fugitive') -- a git wrapper in vim
  -- gitsigns.nvim: show diff markers in the gutter + gitlens {{{
  use({ 'lewis6991/gitsigns.nvim', config = function()
    require('gitsigns').setup {}
  end })-- }}}
  -- }}}
  -- completers {{{
  use('https://github.com/L3MON4D3/LuaSnip') -- the first snippet plugin to beat UltiSnips for me?
  -- nvim-autopairs: auto pairs in lua{{{
  use({ 'https://github.com/windwp/nvim-autopairs', config = function()
    require('nvim-autopairs').setup({
      disable_filetype = { "TelescopePrompt", "fennel" }
    })
  end }) -- }}}
  use('https://github.com/windwp/nvim-ts-autotag') -- use TreeSitter to close and rename tags
  use('https://github.com/hrsh7th/nvim-cmp') -- completion engine written in lua, extendable via plugins
  use('https://github.com/hrsh7th/cmp-nvim-lsp') -- lsp source
  use('https://github.com/hrsh7th/cmp-nvim-lua') -- neovim LUA Api source
  use('https://github.com/hrsh7th/cmp-path') -- path completions
  use('https://github.com/hrsh7th/cmp-cmdline') -- source for cmdline (:, /)
  use('https://github.com/hrsh7th/cmp-buffer') -- buffer source
  -- }}}
  -- debugging {{{
  use('https://github.com/mfussenegger/nvim-dap') -- DAP client
  use('https://github.com/rcarriga/nvim-dap-ui') -- DAP UI
  use('https://github.com/leoluz/nvim-dap-go') -- DAP Adapter for Go
  -- }}}
  -- UI {{{
  use({ 'https://github.com/folke/zen-mode.nvim', config = function() -- {{{
    -- distraction free writing and some other nice things
    require('zen-mode').setup({
      plugins = {
        kitty = {
          enabled = true,
          font = '+4',
        },
        twilight = {
          enabled = true,
        },
        tmux = {
          enabled = true,
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
        backdrop = 0.75,
        width = 120,
        options = {
          signcolumn = 'yes',
          number = false,
          relativenumber = false,
          list = false,
        },
      },
    })
  end }) -- }}}
  use({ 'https://github.com/folke/twilight.nvim', config = function() -- {{{
    -- highlight only portion of text
    require('twilight').setup({})
  end }) -- }}}
  use({ 'https://github.com/rmagatti/goto-preview' }) -- open gotos in floating windows
  use({ 'https://github.com/folke/which-key.nvim', config = function() -- {{{
    -- show possible keys when nvim is waiting for a key press
    require('which-key').setup({
      window = {
        border = 'double',
        position = 'center',
        margin = { 4, 4, 4, 6 }
      }
    })
  end }) -- }}}
  -- lualine.nvim: easy to configure and extend statusline (+tabline, +windowline) {{{
  use({ 'nvim-lualine/lualine.nvim' }) -- }}}
  use('https://github.com/kyazdani42/nvim-web-devicons') -- bunch of icons for web development
  -- fidget.nvim: ui for nvm-lsp progress {{{
  use({ 'https://github.com/j-hui/fidget.nvim', config = function()
    require("fidget").setup {}
  end }) -- }}}
  use({ 'https://github.com/kyazdani42/nvim-tree.lua', config = function() -- {{{
    -- filetree when when :Lex or vinegar is not enough
    require('nvim-tree').setup({
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
    })
  end }) -- }}}
  use('https://github.com/nvim-treesitter/nvim-treesitter-context') -- sticky header
  use('https://github.com/simrat39/symbols-outline.nvim') -- treeview for symbols in current buf
  use({ 'https://github.com/folke/todo-comments.nvim', config = function() -- {{{
    -- easy configurable todo search in comment with support for Trouble
    require('todo-comments').setup {
      signs = false,
      highlight = { keyword = "" } -- using TreeSitter for highlights
    }
  end }) -- }}}
  use('https://github.com/simnalamburt/vim-mundo') -- browser for vim's undo tree, for when git is not enough
  -- use({
  --   "folke/noice.nvim",
  --   event = "VimEnter",
  --   config = function()
  --     require("noice").setup()
  --   end,
  --   requires = {
  --     -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
  --     "MunifTanjim/nui.nvim",
  --     "rcarriga/nvim-notify",
  --   }
  -- })
  -- }}}
  -- themes {{{
  use('https://github.com/rktjmp/lush.nvim') -- for easily creating colorschemes via DSL
  use('https://github.com/folke/tokyonight.nvim')
  use {
    "catppuccin/nvim",
    as = "catppuccin",
    config = function()
      vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha
      require("catppuccin").setup({})
      vim.g.colors_name = 'catppuccin'
    end
  }
  use_local {
    'nocksock/bloop.nvim',
    local_path = 'personal'
  })
  use_local({
    'nocksock/nazgul-vim',
    local_path = 'personal'
  })
  use_local({
    'nocksock/ghash.nvim',
    local_path = 'personal'
  })
  use {
    'rose-pine/neovim',
    as = 'rose-pine',
  }
  -- }}}
  -- beyond coding {{{
  use({ 'renerocksai/telekasten.nvim', config = function() -- {{{
    -- zettelkasten within vim, works great with Obsidian
    local telekastenHome = vim.fn.expand(
      '/Users/nilsriedemann/Library/Mobile Documents/iCloud~md~obsidian/Documents/Development'
    )

    require('telekasten').setup({
      home = telekastenHome,
      dailies = telekastenHome .. '/' .. 'Journal',
      weeklies = telekastenHome .. '/' .. 'Journal',
      templates = telekastenHome .. '/' .. 'Templates',
      subdirs_in_links = false,
      -- markdown file extension
      extension = '.md',
    })
  end }) -- }}}
  use('tpope/vim-eunuch') -- vim sugar for the unix shell commands that need it the most. Like :delete, :move, :chmod
  use('tpope/vim-vinegar') -- improved netrw for file browsing.
  use('mcchrish/nnn.vim') -- using nnn in a floating window (and open file in vim)
  use('metakirby5/codi.vim') -- repl/scratchpad

  -- do.nvim: a tiny task helper plugin{{{
  use_local({ 'nocksock/do.nvim', local_path = 'personal', config = function()
    require("do").setup({
      winbar = true,
    })
  end }) -- }}}
  -- t.nvim: tiny term-toggle plugin{{{
  use_local({ 'nocksock/t.nvim', local_path = 'personal', config = function()
    require("t").setup({})
  end }) -- }}}
  -- }}}

  if is_bootstrap then
    require('packer').sync()
  end
end,
})

if is_bootstrap then
  print '=================================='
  print '    Plugins are being installed'
  print '    Wait until Packer completes,'
  print '       then restart nvim'
  print '=================================='
  return
end

require "snock.plugins.bg"
require "snock.plugins.completion"
require "snock.plugins.dap"
require "snock.plugins.e"
require "snock.plugins.glow"
require "snock.plugins.harpoon-lualine"
require "snock.plugins.hide-linenumbers"
require "snock.plugins.lsp"
require "snock.plugins.on-save"
require "snock.plugins.search-plugins"
require "snock.plugins.treesitter"
require "snock.plugins.lualine"
