return {
  -- core utils
  {
    'nvim-lua/plenary.nvim', -- nvim-lua/plenary.nvim util functions. a dependency of many plugins
    lazy = true
  },
  {
    'kkharji/sqlite.lua', -- sqlite client in lua that some plugins use
    lazy = true
  },
  -- general purpose tools {{{
  {
    'numToStr/Comment.nvim',
    config = true,
    event = { "BufReadPost", "BufNewFile" },
  },
  {
  'tpope/vim-eunuch',                       -- vim sugar for the unix shell commands that need it the most. Like :delete, :move, :chmod
    event = "VeryLazy"
  },
  {
    'tpope/vim-abolish', -- working with words (drastic understatement)
    event = { "BufReadPost", "BufNewFile" },
  },
  {
    'tpope/vim-speeddating',
    event = { "BufReadPost", "BufNewFile" },
  },
  {
    'tpope/vim-repeat', -- makes `.` even more powerful by adding support for plugins
    event = { "BufReadPost", "BufNewFile" },
  },
  {
    'mattn/emmet-vim', -- div.emmet>p.is{awesome}
    event = { "BufReadPost", "BufNewFile" },
  },
  {
    'tpope/vim-scriptease', -- helper commands useful when writing vim scripts etc
    event = { "BufReadPost", "BufNewFile" },
  },
  -- navigating to important files and commands at ludicrous speed
  {
    'ThePrimeagen/harpoon',
    keys = {
      { "<leader>'", ':lua require("harpoon.mark").add_file()<CR>' },
      { "<c-h>",     ':lua require("harpoon.ui").toggle_quick_menu()<CR>' },
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
      { 'ga', '<Plug>(EasyAlign)', mode = "x",         desc = "easy align" },
      { 'ga', '<Plug>(EasyAlign)', desc = "easy align" },
    }
  },
  -- }}}
  -- lsp and Autocompletion stuff {{{
  {
    'windwp/nvim-autopairs', -- nvim-autopairs: auto pairs in lua
    event = 'InsertEnter',
    opts = {
      disable_filetype = { "TelescopePrompt", "fennel" }
    }
  },
  -- }}}
  {
    'folke/which-key.nvim', -- show possible keys when nvim is waiting for a key press
    event = "VeryLazy",
    opts = {
      window = {
        border = 'double',
        position = 'center',
        margin = { 4, 4, 4, 6 }
      }
    }
  },
  {
    'nvim-lualine/lualine.nvim', -- lualine.nvim: easy to configure and extend statusline (+tabline, +windowline)
    event = "VeryLazy",
    config = function() require "configs.lualine" end
  },
  {
    'kyazdani42/nvim-web-devicons', -- bunch of icons for web development
    lazy = true
  },
  {
    'simrat39/symbols-outline.nvim', -- treeview for symbols in current buf
    keys = {
      {
        '<leader>to', ':SymbolsOutline<cr>', desc = "[t]oggle [o]utline"
      }
    }
  },
  {
    'folke/todo-comments.nvim', -- easy configurable todo search in comment with support for Trouble
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = false,
      highlight = { keyword = "" } -- using TreeSitter for highlights
    }
  },
  {
    'simnalamburt/vim-mundo', -- browser for vim's undo tree, for when git is not enough
    keys = {
      { '<leader>tu', ':MundoToggle<CR>', desc = "toggle undo-tree" }
    }
  },
  {
    'tpope/vim-vinegar', -- improved netrw for file browsing.
    event = 'VeryLazy',
  },
  {
    'mcchrish/nnn.vim', -- using nnn in a floating window (and open file in vim)
    event = 'VeryLazy',
  },
}
