-- :LineNrToggle
-- -------------
-- 
-- Hide line numbers without jumping or changing rnu nu settings. Results in
-- a padding that feels nice in minimal modes.

-- force nvim to recalculate all the highlights or whatever.
-- otherwise LineNr won't be updated. Other hl groups work without issues.
local function force_hl_update()--{{{
  -- turning off TS highlight mod apparently does the trick... sometimes.
  local ts_cmd = require('nvim-treesitter.configs').commands
  ts_cmd.TSDisable.run('highlight')
  vim.schedule(function() ts_cmd.TSEnable.run('highlight') end) -- re-enable on next tick
end--}}}

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
    force_hl_update() -- either bug or necessary due to perf optimizations
  end
end--}}}

vim.api.nvim_create_user_command("LineNrToggle", toggle, {})
