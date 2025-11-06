local bag = require "baggage"
    .from {
      'https://github.com/rose-pine/neovim',
    }

bag.setup("rose-pine")
vim.cmd.colorscheme 'rose-pine'
