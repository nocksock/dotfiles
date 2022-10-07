-- :LineNrToggle
-- -------------
-- 
-- Hide line numbers without jumping or changing rnu nu settings. Results in
-- a padding that feels nice in minimal modes.

local function is_hidden()--{{{
  local get = vim.api.nvim_get_hl_by_name
  return get("Normal", true).background == get("LineNr", true).foreground
end--}}}
local function toggle()--{{{
  if is_hidden() then
    print("showing LineNr")
    vim.cmd(string.format([[ set background=%s ]], vim.o.background)) -- reloads colorscheme
  else
    print("hiding LineNr")
    vim.api.nvim_set_hl(0, "LineNr", { fg = "bg" })
  end
end--}}}

vim.api.nvim_create_user_command("LineNrToggle", toggle, {})
