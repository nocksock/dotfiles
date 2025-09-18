local function is_file_open(filepath)
  local bufnr = vim.fn.bufnr(vim.fn.fnamemodify(filepath, ":p"))
  return bufnr ~= -1 and bufnr or nil, bufnr
end

return function(config)
  local config = config or R "poon.lua.config"()
  local filepath = R "poon.lua.get_poonfile"(config)
  local is_open, bufnr = is_file_open(filepath)

  if is_open then
    return bufnr
  else
    local bufnr = vim.api.nvim_create_buf(false, false)

    vim.api.nvim_buf_call(bufnr, function()
      vim.cmd.edit(vim.fn.fnameescape(filepath))
    end)
    return bufnr
  end

  return bufnr
end
