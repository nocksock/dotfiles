local M = {}

function M.maybe_call(f, ...) if f then f(...) end end

function M.cycle(values, value) --{{{
  local next_val_idx = ((M.index_of(values, value)) % #values) + 1
  return values[next_val_idx]
end --}}}
function M.default(val, default)--{{{
  if val == "" or val == nil then
    return default
  end

  return val
end--}}}
function M.index_of(tbl, value) --{{{
  for idx, tval in ipairs(tbl) do
    if value == tval then
      return idx
    end
  end
end --}}}
function M.is_visible(bufnr) --{{{
  local wins = vim.api.nvim_tabpage_list_wins(0)
  for _, handle in ipairs(wins) do
    if vim.api.nvim_win_get_buf(handle) == bufnr then
      return true, handle
    end
  end
  return false, nil
end --}}}
function M.invert(fn) --{{{
  return function(...)
    return not fn(...)
  end
end --}}}

-- buffer helper:

function M.open_float_buf(bufnr) --{{{
  local padding = {
    x = 8,
    y = 4,
  }
  local max_width = vim.opt.columns:get()
  local max_height = vim.opt.lines:get()

  local win = vim.api.nvim_open_win(bufnr, true, {
    relative = "win",
    style = "minimal",
    border = "double",
    noautocmd = true,
    col = padding.x,
    row = padding.y,
    width = max_width - (2 * padding.x),
    height = max_height - (2 * padding.y),
  })

  vim.cmd("startinsert")

  return {
    buffer = bufnr,
    window = win
  }
end --}}}

---find the root project directory based on filenames
---@param filenames table
---@return unknown
function M.root_dir(filenames)
  return vim.fs.dirname(
    vim.fs.find(
      filenames,
      { upward = true }
    )[1]
  )
end

return M
-- vim: fen fdm=marker fdl=0
