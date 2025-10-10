local bag = require "baggage"
    .from {
      'https://github.com/rktjmp/lush.nvim',
      'https://github.com/rose-pine/neovim',
      'https://github.com/Mofiqul/dracula.nvim'
    }

bag.setup("rose-pine")
vim.cmd.colorscheme 'rose-pine'
