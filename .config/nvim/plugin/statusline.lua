-- statusline
-- a super simple, custom status bar written in lua*

local flaggedFile = "%(%m%r%h %)%f"
local flex = " %="
local bar = "|"
local filetype = "%y "

-- creates a function that appends the context to the groupName
--    eg. createContext("Active")("Foo") -> "FooActive"
local function createContext(context, wrap)
  local function cg(name)
    return "%#".. name .. "#"
  end

  return function(groupName)
    if wrap == nil or wrap == true then
      return cg(groupName .. context)
    end

    return groupName .. context
  end
end

-- local function system(cmd)
--   local handle = io.popen(cmd)
--   local result = handle:read("*a")
--   handle:close()
--   return result
-- end

local get_git_status = function()
  -- TODO: check if git is even present
  return ''
  -- return system('git status -s | cut -c1-2 | uniq | sed "s/??/+/" | tr "\n" " " | sed "s/ //g" | tr "[:upper:]" "[:lower:]"')
end

local get_git_branch = function()
  -- TODO: check if git is even present
  return ''
  -- return system('git branch --show-current | tr "\n" " "'):gsub(" ","");
end

local get_mode = function()
  return vim.api.nvim_get_mode().mode:upper()
end

local stl = function(group, separator)
  if separator == nil then
    separator = " "
  end

  return table.concat({
    group("stlModeMsg"), get_mode(), group("stlLeft"), flaggedFile, group("stlMid"), get_git_branch(), bar, get_git_status(), flex, group("stlRight"), filetype
  }, separator)
end

function StatusLine(type)
  if type == "active" then
    return stl(createContext(""))
  end

  if type == "inactive" then
    return stl(createContext("NC"))
  end
end

-- TODO: when updating to new neovim version, rewrite this using lua
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

