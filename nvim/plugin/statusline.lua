local harpoon = require('harpoon')
local harpoon_mark = require('harpoon.mark')
local invert = require('snock.utils').invert

local has_marks = function()
  return harpoon_mark.get_length() > 0
end

-- TODO: create proper lualine extension (see lualine/components/buffer)
local mark_keys = { "f", "d", "s", "a", "j", "k", "l", ";" } -- or use asdfg, 12345 or whatever.
local marks = function() --{{{
  local marks = harpoon.get_mark_config().marks
  local current_mark_idx = harpoon_mark.get_current_index()
  local output = {}

  for i, key in ipairs(mark_keys) do
    local mark = marks[i]
    if mark then
      local filename = vim.fs.basename(mark.filename)
      local label = ' ' .. key .. ': ' .. filename .. ' '

      if i == current_mark_idx then
        table.insert(output, '%#TabLineSel#' .. label)
      else
        table.insert(output, '%#TabLine#' .. label)
      end
    end
  end

  return '%#TabLineFill#' .. table.concat(output, '')
end --}}}

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
  tabline = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {
      {
        marks
      },
      {
        "buffers",
        cond = invert(has_marks),
        mode = 2
      }
    },

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
