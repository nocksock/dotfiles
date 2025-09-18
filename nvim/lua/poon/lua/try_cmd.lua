local function starts_with(str, start)
  return str:sub(1, #start) == start
end

return function(_config)
  local line = vim.api.nvim_get_current_line()

  if not starts_with(line, ':') then
    return 
  end

  vim.cmd(line)
end

