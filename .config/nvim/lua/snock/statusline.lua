-- statusline
-- a super simple, custom status bar with

local function cg(name)
  return "%#".. name .. "#"
end

local function system(cmd)
  local handle = io.popen(cmd)
  local result = handle:read("*a")
  handle:close()
  return result
end

local get_git_status = function()
  return system('git status -s | cut -c1-2 | uniq | sed "s/??/+/" | tr "\n" " " | sed "s/ //g" | tr "[:upper:]" "[:lower:]"')
end

local get_git_branch = function()
  return system('git branch --show-current | tr "\n" " "'):gsub(" ","");
end

local get_mode = function()
  return vim.api.nvim_get_mode().mode:upper()
end

local flaggedFile = "%(%m%r%h %)%f"
local flex = " %="
local bar = "|"
local separator = " "
local filetype = "%y "

function StatusLineActive()
  return table.concat({
      cg("stlModeMsg"), get_mode(), cg("stlLeft"), flaggedFile, cg("stlMid"), get_git_branch(), bar, get_git_status(), flex, cg("stlRight"), filetype
    }, separator)
end

function StatusLineInactive()
  return table.concat({
      cg("stlModeMsgNC"), get_mode(), cg("stlLeftNC"), flaggedFile, cg("stlMidNC"), get_git_branch(), bar, get_git_status(), flex, cg("stlRightNC"), filetype
    }, separator)
end

function StatusLine(type)
  if type == "active" then
    return StatusLineActive();
  end

  if type == "inactive" then
    return StatusLineInactive();
  end
end

vim.api.nvim_exec([[
  highlight! link stlModeMsg ModeMsg
  highlight! link stlLeftNC StatusLineNC
  highlight! link stlMidNC StatusLineNC
  highlight! link stlRightNC StatusLineNC
  highlight! link stlLeft StatusLine
  highlight! link stlMid StatusLine
  highlight! link stlRight StatusLine

  augroup statusline
    au!
    autocmd WinEnter,BufEnter * setlocal statusline=%!v:lua.StatusLine('active')
    autocmd WinLeave,BufLeave * setlocal statusline=%!v:lua.StatusLine('inactive')
  augroup END
]], false)
