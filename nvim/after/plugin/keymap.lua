vim.keymap.set('n', '<leader>ti', function()
  local previous = vim.diagnostic.config()
  vim.diagnostic.config({ virtual_text = not previous.virtual_text })
end)
