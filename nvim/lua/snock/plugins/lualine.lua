require('lualine').setup {
  options = {
    icons_enabled = false,
    theme = 'auto',
    component_separators = '',
    section_separators = { left = '', right = '' },
    disabled_filetypes = {},
  },
  sections = {
    lualine_a = { { 'mode' } },
    lualine_b = {},
    lualine_c = {
      {
        'filename',
        newfile_status = true,
        path = 1,
        symbols = {
          modified = '*',
          readonly = '',
          unnamed  = '[No Name]',
          newfile  = ' new',
        }
      }
    },
    lualine_x = { 'diagnostics', 'branch' },
    lualine_y = {},
    lualine_z = {}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { { 'filename', path = 1 } },
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {
    lualine_a = { { require("snock.plugins.harpoon-lualine") } },
    lualine_b = {},
    lualine_z = { { 'tabs', mode = 0 } },
  },
  -- currently using the implementation of do.nvim
  -- winbar = {
  --   -- lualine_a = { require("do").view },
  -- },
  -- inactive_winbar = {
  --   -- lualine_a = { require("do").view_inactive }
  -- },
  extensions = {},
}
