return {
  {
    'folke/twilight.nvim', -- highlight only portion of text
    cmd = "Twilight",
    opts = {
      inactive = true,
      context = 0, -- amount of lines we will try to show around the current line
      expand = {
        "function", "method", "if_statement", "table"
      }
    }
  }, {
  'folke/zen-mode.nvim',
  cmd = "ZenMode",
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
}
}
