require('packer').startup(function(use)
  -- essentials
	use('https://github.com/nvim-lua/plenary.nvim') -- util functions. a dependency of many plugins
	use('https://github.com/alvan/vim-closetag') -- auto close HTML/JSX tags
	use('https://github.com/dstein64/vim-startuptime') -- find the startup bottleneck
	use('https://github.com/editorconfig/editorconfig-vim') -- loads settings from .editorconfig if present
	use('https://github.com/godlygeek/tabular') -- align text at character. More powerful than :!column
	use('https://github.com/junegunn/gv.vim') -- commit browser
	use('https://github.com/kyazdani42/nvim-web-devicons')
	use('https://github.com/mattn/emmet-vim') -- div.emmet>p.is{awesome}
	use('https://github.com/numToStr/Comment.nvim') -- comments, with more smartness
	use('https://github.com/nvim-telescope/telescope.nvim') -- extensive picker plugin/framework
	use('https://github.com/nvim-telescope/telescope-symbols.nvim')
	use('https://github.com/tpope/vim-abolish') -- working with words (drastic understatement)
	use('https://github.com/tpope/vim-eunuch') -- vim sugar for the unix shell commands that need it the most. Like :delete, :move, :chmod
	use('https://github.com/tpope/vim-fugitive') -- a git wrapper in vim
	use('https://github.com/tpope/vim-repeat') -- makes `.` even more powerful by adding support for plugins
	use('https://github.com/tpope/vim-surround') -- quoting/parenthesizing made simple. Extends functionality of s
	use('https://github.com/tpope/vim-vinegar') -- improved netrw for file browsing.
	use('https://github.com/wbthomason/packer.nvim') -- packer can manage itself
	use({ 'https://github.com/nvim-telescope/telescope-fzf-native.nvim', run = 'make' })

  -- completers
	use('https://github.com/windwp/nvim-autopairs') -- auto pairs in lua
	use('https://github.com/L3MON4D3/LuaSnip') -- the first snippet plugin to beat UltiSnips for me?
	use('https://github.com/hrsh7th/nvim-cmp') -- smart completion
	use('https://github.com/hrsh7th/cmp-path')
	use('https://github.com/hrsh7th/cmp-buffer')
	use('https://github.com/hrsh7th/cmp-cmdline')
	use('https://github.com/hrsh7th/cmp-nvim-lua')
	use('https://github.com/hrsh7th/cmp-nvim-lsp')

  -- lsp stuff
	use('https://github.com/neovim/nvim-lspconfig') --  easy configs for language servers
	use('https://github.com/jose-elias-alvarez/null-ls.nvim') -- use neovim as ls server to inject code-actions and mor via lua
	use('https://github.com/jose-elias-alvarez/nvim-lsp-ts-utils')
	use('https://github.com/folke/trouble.nvim') -- pretty list for LSP diagnostics

  -- helper
	use('https://github.com/tpope/vim-scriptease') -- helper commands useful when writing vim scripts etc
	use({ '~/personal/rucksack.nvim', requires = 'nvim-lua/plenary.nvim' }) -- custom neovim plugin for stashing and persisting code for later user
	use('https://github.com/theprimeagen/refactoring.nvim') -- TS powered refactorings
	use('https://github.com/ThePrimeagen/harpoon') -- navigating to important files and commands at ludicrous speed

	use('https://github.com/simnalamburt/vim-mundo') -- browser for vim's undo tree, for when git is not enough
	use('https://github.com/lewis6991/gitsigns.nvim') -- show diff markers in the gutter + gitlens
	use('https://github.com/akinsho/toggleterm.nvim') -- quick access to builtin terminal
	use('https://github.com/mcchrish/nnn.vim') -- using nnn in a floating window (and open file in vim)

  -- ui
	use('https://github.com/folke/zen-mode.nvim') -- distraction free writing and some other nice things
	use('https://github.com/folke/twilight.nvim') -- highlight only portion of text
	use('https://github.com/rmagatti/goto-preview') -- open gotos in floating windows
	use('https://github.com/princejoogie/tailwind-highlight.nvim') -- show tailwind colors

  -- themes
  -- note: I mapped `<leader>ttt` to `:Telescope colorschemes` and some mappings
  -- to access some colorschemes directly.
	use('https://github.com/rktjmp/lush.nvim') -- for easily creating colorschemes via DSL
	use('https://github.com/nlknguyen/papercolor-theme') -- for moments I need a bright theme
	use('https://github.com/rafi/awesome-vim-colorschemes') -- huge collection of colorschemes
	use('https://github.com/ayu-theme/ayu-vim')
  use('https://github.com/folke/tokyonight.nvim')
	use('~/personal/bloop-vim')
	use('~/personal/nazgul-vim')
	use('~/personal/ghash-nvim')

  -- beyond coding
  use('https://github.com/mfussenegger/nvim-dap') -- Debugger
	use('https://github.com/rcarriga/nvim-dap-ui') -- UI for the debugger
	use('https://github.com/renerocksai/telekasten.nvim') -- zettelkasten within vim
	use('https://github.com/tpope/vim-dadbod') -- make db connections from within vim
	use('https://github.com/kristijanhusak/vim-dadbod-ui') -- ui for vim-dadbox
	use('https://github.com/nvim-treesitter/nvim-treesitter')
	use('https://github.com/nvim-treesitter/playground')
end)

require('nvim-web-devicons').setup()
