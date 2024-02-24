local setup = require "baggage"
  .from {
    'https://github.com/rktjmp/lush.nvim',
    'https://github.com/rose-pine/neovim'
  }

setup("rose-pine")

vim.cmd.colorscheme 'rose-pine'
