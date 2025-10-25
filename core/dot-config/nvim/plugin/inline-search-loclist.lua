-- turn currently active search into location list
vim.keymap.set('c', '<c-l>', function()
  local cmdtype = vim.fn.getcmdtype()
  if cmdtype ~= '/' and cmdtype ~= '?' then
    return
  end

  vim.cmd.lvimgrep('/' .. vim.fn.getcmdline() .. '/ %')
  return '<esc>:lwindow<cr><cmd>nohl<cr><cr>'
end, { expr = true })
