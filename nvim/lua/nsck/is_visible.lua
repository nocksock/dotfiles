return function(bufnr)
  local wins = vim.api.nvim_tabpage_list_wins(0)
  for _, handle in ipairs(wins) do
    if vim.api.nvim_win_get_buf(handle) == bufnr then
      return true, handle
    end
  end
  return false, nil
end
