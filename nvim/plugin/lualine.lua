local symbols = {
  modified = '%#ErrorMsg#*',
  readonly = '  ',
  unnamed  = ' [No Name]',
  newfile  = ' %#WarningMsg# new',
}

local setup = require "baggage"
    .from('https://github.com/nvim-lualine/lualine.nvim')

require('lualine').setup({
      options = {
        icons_enabled = false,
        theme = 'auto',
        component_separators = '',
        section_separators = { left = '', right = '' },
        disabled_filetypes = {},
      },
      sections = {
        lualine_a = {},
        lualine_b = { },
        lualine_c = {
          {
            'filename',
            newfile_status = true,
            path = 1,
            symbols = symbols
          }
        },
        lualine_x = { 'diagnostics', 'branch' },
        lualine_y = { 'searchcount' },
        lualine_z = {}
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { { 'filename', path = 1, newfile_status = true, symbols = symbols } },
        lualine_x = {},
        lualine_y = {},
        lualine_z = {}
      },
      tabline = {
        -- lualine_a = {},
        -- lualine_b = {},
        -- lualine_c = {},
        -- lualine_x = {},
        -- lualine_y = {},
        -- lualine_z = {}
      },
      winbar = {},
      inactive_winbar = {},
      extensions = {},
    })
