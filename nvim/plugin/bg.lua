function index_of(tbl, value) --{{{
  for idx, tval in ipairs(tbl) do
    if value == tval then
      return idx
    end
  end
end --}}}
function cycle(values, value) --{{{
  local next_val_idx = ((M.index_of(values, value)) % #values) + 1
  return values[next_val_idx]
end --}}}

vim.api.nvim_create_user_command("BG", function()
  vim.o.background = cycle({"dark", "light"}, vim.o.background)
end, {})
