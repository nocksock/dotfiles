local harpoon = require('harpoon')
local harpoon_mark = require('harpoon.mark')

-- TODO: create proper lualine extension (see lualine/components/buffer)
local mark_keys = { "f", "d", "s", "a", "j", "k", "l", ";" } -- or use asdfg, 12345 or whatever.
local harpoon_component = function() --{{{
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

return harpoon_component
