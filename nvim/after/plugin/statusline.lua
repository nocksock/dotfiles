local harpoon = require('harpoon')
local harpoon_mark = require('harpoon.mark')
local invert = require('snock.utils').invert

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
    lualine_b = { { 'branch' }, 'diff', 'diagnostics' },
    lualine_c = { { 'filename', path = 1 } },
    lualine_x = { 'location' },
    lualine_y = { {
      'filetype',
      fmt = function(str)
        return vim.lsp.buf.server_ready() and str .. "+" or str
      end,
      icons_enabled = true
    } },
    lualine_z = {}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { { 'filename' } },
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  },
  -- tabline = {},
  extensions = {},
}
