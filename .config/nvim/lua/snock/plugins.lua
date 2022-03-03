vim.cmd [[packadd packer.nvim]]

require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  use 'tpope/vim-fugitive'            --  a git wrapper in vim
  use 'tpope/vim-abolish'             --  working with words (drastic understatement)
  use 'SirVer/ultisnips' -- ultimate snippet manager
  use 'tpope/vim-vinegar'             --  improved netrw for file browsing.
  use 'tpope/vim-scriptease'          --  helpers for vim scripting and plugin authoring
  use 'alvan/vim-closetag'
  use 'itchyny/lightline.vim' -- easy status bar
  use 'itchyny/vim-gitbranch' -- gitbranch display in lightline
  use 'sheerun/vim-polyglot' -- tons of syntax
  use 'tpope/vim-surround'            --  quoting/parenthesizing made simple. Extends functionality of S
  use {'tpope/vim-dispatch', opt = true, cmd = {'Dispatch', 'Make', 'Focus', 'Start'}}
  use 'tpope/vim-repeat'              --  makes . even more powerful by adding suppor for plugins
  use 'tpope/vim-commentary'          --  comment stuff out and back in via gc/gcc
  use 'tpope/vim-eunuch'              --  Vim sugar for the UNIX shell commands that need it the most. Like :Delete, :Move, :Chmod
  use 'jiangmiao/auto-pairs'          --  auto insert/delete brackets, parens, quotes etc
  use 'neovim/nvim-lspconfig'         --  nvim ls
  use 'editorconfig/editorconfig-vim' --  loads settings from .editoconfig if present
  use 'godlygeek/tabular'             --  align text at character. more powerful than :!column
  use 'simnalamburt/vim-mundo'        --  browser for vim's undo tree, for when git is not enough
  use 'junegunn/gv.vim'               --  commit browser
  use 'pantharshit00/vim-prisma'      --  syntax for prisma file
  use 'voldikss/vim-floaterm'         --  floating terminal
  use 'tpope/vim-projectionist'
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'
  use 'nvim-telescope/telescope-fzy-native.nvim'
  use 'neovim/nvim-lspconfig'
  use 'jose-elias-alvarez/null-ls.nvim'
  use 'jose-elias-alvarez/nvim-lsp-ts-utils'

  -- themes
  use 'nocksock/bloop-vim'            --  my own colorscheme, work in progress, available at github.com/nocksock/bloop-vim
  use 'NLKNguyen/papercolor-theme'
  use 'rakr/vim-one'
  use {'dracula/vim', as = 'dracula'}
end)
