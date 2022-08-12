local breadcrumbs = require('breadcrumbs')
local harpoon = require('harpoon')
local harpoon_mark = require('harpoon.mark')

breadcrumbs.setup()

local mark_keys = { "f", "d", "s", "a" } -- or use asdfg, 12345 or whatever.
local marks = function()
  local marks = harpoon.get_mark_config().marks
  local current_mark_idx = harpoon_mark.get_current_index()
  local output = {}

  for i, mark in ipairs(marks) do
    local filename = vim.fs.basename(mark.filename)
    local label = ' ' .. mark_keys[i] .. ': ' .. filename .. ' '

    if i == current_mark_idx then
      table.insert(output, '%#lualine_b_normal#' .. label)
    else
      table.insert(output, '%#lualine_c_inactive#' .. label)
    end
  end

  return table.concat(output, '')
end

require('lualine').setup {
  options = {
    icons_enabled = false,
    theme = 'auto',
    component_separators = '',
    section_separators = { left = '', right = '' },
    disabled_filetypes = {},
    globalstatus = false,
  },
  sections = {
    lualine_a = { { 'mode' } },
    lualine_b = { { 'branch' }, 'diff', 'diagnostics' },
    lualine_c = { { 'filename', path = 1 } },
    lualine_x = {},
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
  tabline = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { marks },
    lualine_x = {},
    lualine_y = {},
    lualine_z = { {
      'tabs',
      mode = 0,
      tabs_color = {
        active = 'lualine_b_normal',
        inactive = 'lualine_c_normal'
      }
    } },
  },
  extensions = {},
}
