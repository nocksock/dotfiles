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
  use('https://github.com/numToStr/Comment.nvim') -- comments, with more smartness
  use('https://github.com/tpope/vim-abolish') -- working with words (drastic understatement)
  use('https://github.com/tpope/vim-repeat') -- makes `.` even more powerful by adding support for plugins
  use('https://github.com/mattn/emmet-vim') -- div.emmet>p.is{awesome}
  use('https://github.com/tpope/vim-scriptease') -- helper commands useful when writing vim scripts etc
  use('https://github.com/theprimeagen/refactoring.nvim') -- Treesitter powered refactorings
  -- navigating to important files and commands at ludicrous speed
  use_local({
    'ThePrimeagen/harpoon',
    local_path = 'forks',
  })
  use('https://github.com/godlygeek/tabular') -- align text at character. More powerful than :!column

  -- use('https://github.com/tpope/vim-surround') -- quoting/parenthesizing made simple. Extends functionality of s
  use("https://github.com/kylechui/nvim-surround") -- replacement of vim-surround with some neat features like `dsf` powered by TreeSitter
  -- }}}
  -- telescope  {{{
  use('https://github.com/nvim-telescope/telescope.nvim') -- extensive picker plugin/framework
  use({ 'https://github.com/nvim-telescope/telescope-fzf-native.nvim', run = 'make' })
  -- }}}
  -- lsp stuff {{{
  use('https://github.com/williamboman/nvim-lsp-installer')
  -- use('https://github.com/williamboman/mason.nvim') -- TODO: use mason
  use('https://github.com/neovim/nvim-lspconfig') --  easy configs for language servers
  use('https://github.com/jose-elias-alvarez/null-ls.nvim') -- use neovim as ls server to inject code-actions and mor via lua
  use('https://github.com/jose-elias-alvarez/nvim-lsp-ts-utils')
  use('https://github.com/folke/trouble.nvim') -- pretty list for LSP diagnostics
  use('https://github.com/ray-x/lsp_signature.nvim') -- show function signatures from LSP when typing
  use("https://github.com/glepnir/lspsaga.nvim")
  -- }}}
  -- treesitter {{{
  use('https://github.com/nvim-treesitter/nvim-treesitter') -- simple API for treesitter for configuration and interactions
  use('https://github.com/nvim-treesitter/playground') -- visual representation and query playground for the AST of TS
  use('https://github.com/nvim-treesitter/nvim-treesitter-textobjects') -- create additional textobjects via TreeSitter (eg `if` => `@function.inner`)
  -- }}}
  -- git things {{{
  use('https://github.com/tpope/vim-fugitive') -- a git wrapper in vim
  use('https://github.com/lewis6991/gitsigns.nvim') -- show diff markers in the gutter + gitlens
  -- }}}
  -- completers {{{
  use('https://github.com/windwp/nvim-autopairs') -- auto pairs in lua
  use('https://github.com/windwp/nvim-ts-autotag') -- use TreeSitter to close and rename tags
  use('https://github.com/hrsh7th/nvim-cmp') -- completion engine written in lua, extendable via plugins
  use('https://github.com/hrsh7th/cmp-nvim-lsp') -- lsp source
  use('https://github.com/hrsh7th/cmp-nvim-lua') -- neovim LUA Api source
  use('https://github.com/hrsh7th/cmp-path') -- path completions
  use('https://github.com/hrsh7th/cmp-cmdline') -- source for cmdline (:, /)
  use('https://github.com/hrsh7th/cmp-buffer') -- buffer source
  -- }}}
  -- snippets {{{
  use('https://github.com/L3MON4D3/LuaSnip') -- the first snippet plugin to beat UltiSnips for me?
  -- }}}
  -- debugging {{{
  use('https://github.com/mfussenegger/nvim-dap') -- DAP client
  use('https://github.com/rcarriga/nvim-dap-ui') -- DAP UI
  use('https://github.com/leoluz/nvim-dap-go') -- DAP Adapter for Go
  -- }}}
  -- UI {{{
  use('https://github.com/folke/zen-mode.nvim') -- distraction free writing and some other nice things
  use('https://github.com/folke/twilight.nvim') -- highlight only portion of text
  use({ 'https://github.com/rmagatti/goto-preview' }) -- open gotos in floating windows
  use('https://github.com/folke/which-key.nvim') -- show possible keys when nvim is waiting for a key press
  use('https://github.com/nvim-lualine/lualine.nvim') -- easy to configure and extend statusline (+tabline, +windowline)
  use('https://github.com/kyazdani42/nvim-web-devicons') -- bunch of icons for web development
  -- ui for nvm-lsp progress
  use({
    'https://github.com/j-hui/fidget.nvim',
    config = function ()
      require("fidget").setup {}
    end
  })
  use('https://github.com/kyazdani42/nvim-tree.lua') -- filetree when when :Lex or vinegar is not enough
  use('https://github.com/nvim-treesitter/nvim-treesitter-context') -- sticky header
  use('https://github.com/simrat39/symbols-outline.nvim') -- treeview for symbols in current buf
  -- use('https://github.com/stevearc/aerial.nvim') -- alternative to symbols-outline.nvim
  use('https://github.com/folke/todo-comments.nvim') -- easy configurable todo search in comment with support for Trouble
  use('https://github.com/simnalamburt/vim-mundo') -- browser for vim's undo tree, for when git is not enough
  use('https://github.com/sunjon/Shade.nvim') -- dim inactive windows
  -- }}}
  -- themes {{{
  use('https://github.com/rktjmp/lush.nvim') -- for easily creating colorschemes via DSL
  use('https://github.com/folke/tokyonight.nvim')

  use_local({
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
  -- }}}

  -- beyond coding {{{
  use('https://github.com/renerocksai/telekasten.nvim') -- zettelkasten within vim, works great with Obsidian
  use('https://github.com/tpope/vim-eunuch') -- vim sugar for the unix shell commands that need it the most. Like :delete, :move, :chmod
  use('https://github.com/tpope/vim-vinegar') -- improved netrw for file browsing.
  use('https://github.com/mcchrish/nnn.vim') -- using nnn in a floating window (and open file in vim)
  use('https://github.com/metakirby5/codi.vim') -- repl/scratchpad

  -- a tiny task helper plugin
  use_local({
    'nocksock/do.nvim',
    local_path = 'personal' ,
    config = function()
      require("do").setup({})
    end
  })
  -- tiny term-toggle plugin
  use_local({
    'nocksock/t.nvim',
    local_path = 'personal',
    config = function()
      require("t").setup({})
    end
  })
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

