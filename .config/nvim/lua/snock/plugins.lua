require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  -- general purppose plugins
  use 'tpope/vim-abolish'             -- working with words (drastic understatement)
  use 'alvan/vim-closetag'            -- auto close html/jsx tags
  use 'tpope/vim-surround'            -- quoting/parenthesizing made simple. Extends functionality of S
  use 'tpope/vim-repeat'              -- makes . even more powerful by adding suppor for plugins
  use 'tpope/vim-commentary'          -- comment stuff out and back in via gc/gcc
  use 'tpope/vim-eunuch'              -- Vim sugar for the UNIX shell commands that need it the most. Like :Delete, :Move, :Chmod
  use 'jiangmiao/auto-pairs'          -- auto insert/delete brackets, parens, quotes etc
  use 'editorconfig/editorconfig-vim' -- loads settings from .editoconfig if present
  use 'godlygeek/tabular'             -- align text at character. more powerful than :!column
  use 'SirVer/ultisnips'              -- ultimate snippet manager, still the best.

  -- scripting
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'         -- util functions. a dependency of many plugins

  -- process management etc
  use {
    'tpope/vim-dispatch',
    opt = true, cmd = {'Dispatch', 'Make', 'Focus', 'Start'}
  }
  use 'voldikss/vim-floaterm'         -- floating terminal
  use 'tpope/vim-dadbod'              -- make db connections from within vim
  use 'kristijanhusak/vim-dadbod-ui'  -- ui for vim-dadbox

  -- syntax
  use 'nvim-treesitter/nvim-treesitter'
  use 'nvim-treesitter/playground'
  use 'pantharshit00/vim-prisma'      --  syntax for prisma file
  use 'sheerun/vim-polyglot'          -- tons of syntax

  -- git
  use 'simnalamburt/vim-mundo'        -- browser for vim's undo tree, for when git is not enough
  use 'lewis6991/gitsigns.nvim'       -- show diff markers in the gutter + gitlens
  use 'tpope/vim-fugitive'            -- a git wrapper in vim
  use 'itchyny/vim-gitbranch'         -- gitbranch display in lightline
  use 'junegunn/gv.vim'               -- commit browser

  -- auto-completion
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'

  -- navigation
  use 'nvim-telescope/telescope.nvim'
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use 'tpope/vim-vinegar'             --  improved netrw for file browsing.

  -- lsp
  use 'neovim/nvim-lspconfig'         --  easy configs for language servers
  use 'jose-elias-alvarez/null-ls.nvim'
  use 'jose-elias-alvarez/nvim-lsp-ts-utils'
  use {
      "ThePrimeagen/refactoring.nvim",
      requires = {
          {"nvim-lua/plenary.nvim"},
          {"nvim-treesitter/nvim-treesitter"}
      }
  }

  -- looks and themes
  use 'rktjmp/lush.nvim'              -- for easily creating colorschemes via DSL
  use '~/personal/bloop-vim'          -- my own colorscheme, work in progress, available at github.com/nocksock/bloop-vim
  use '~/personal/bloop-nvim'         -- a new, custom colorscheme for nvim, not yet available
  use '~/forks/ayu-vim'
  use 'NLKNguyen/papercolor-theme'
  use 'rakr/vim-one'
  use {'dracula/vim', as = 'dracula'}
  -- use 'itchyny/lightline.vim'         -- easy status bar
end)
