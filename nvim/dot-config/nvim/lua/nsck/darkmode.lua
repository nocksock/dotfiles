local function get_mode()
  local target = "light"

  if vim.fn.system("cat " .. vim.fn.expand("~/.darkmode")) == "1\n" then
    target = "dark"
  end

  return target
end


local function set_background_by_mode()
  local current = get_mode()
  if vim.o.background ~= current then
    vim.o.background = current
  end
end


return {
  get_mode = get_mode,
  set_background_by_mode = set_background_by_mode
}
