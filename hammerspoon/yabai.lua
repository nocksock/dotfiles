local yabai = hs.hotkey.modal.new({ "cmd", "control", "shift", "option" }, "y")
local task = require('utils').task

-- helper functions {{{
local function to_param(cmd_str)
  local cmd = hs.fnutils.split(cmd_str, " ")
  table.insert(cmd, 1, "-m")
  return cmd
end

---@alias Runnable string|function
---@param cmd Runnable
local function run(cmd)
  if type(cmd) == "function" then
    return cmd()
  end

  if type(cmd) == "string" then
    cmd = to_param(cmd)
  end

  hs.task.new("/opt/homebrew/bin/yabai", nil, function(_, ...)
    print("stream", hs.inspect(table.pack(...)))
    return true
  end, cmd):start()
end

---map something in yabai mode
---@param mod? string
---@param key string|Runnable
---@param cmd Runnable|Runnable[]
---@overload fun(key, cmd)
local function ymap(mod, key, cmd)
  if cmd == nil then
    cmd = key
    key = mod
    mod = nil
  end

  cmd = type(cmd) == "table" and cmd or { cmd }

  yabai:bind(mod, key, nil, function()
    for _, mapped_cmd in ipairs(cmd) do
      if type(mapped_cmd) == "string" then
        run(mapped_cmd)
      end
      if type(mapped_cmd) == "function" then
        mapped_cmd()
      end
    end
  end)
end

---@param key string
---@param cmd Runnable|Runnable[]
local function hmap(key, cmd)
  hs.hotkey.bind(HYPER, key, nil, function()
    run(cmd)
  end)
end
-- }}}

function yabai:entered()
  run("config window_border_width 16")
end

function yabai:exited()
  run("config window_border_width 2")
  hs.alert.closeAll()
end

-- ymap("escape", function() yabai:exit() end)
-- ymap("return", function() yabai:exit() end)
--
-- ymap("p", {
--   "window --grid 6:4:1:1:2:4",
-- })
--
-- ymap("f", "window --toggle float")
-- ymap(".", "window --toggle sticky")
--
-- ymap("shift", "f", "window --toggle zoom-fullscreen")
-- ymap("shift", "r", task("/Users/nilsriedemann/.yabairc"))
--
-- ymap("x", {
--   "window --close",
--   "window --focus recent"
-- })
--
-- ymap("h", "window --focus west")
-- ymap("j", "window --focus south")
-- ymap("k", "window --focus north")
-- ymap("l", "window --focus east")
--
-- ymap("ctrl", "h", "window --swap west")
-- ymap("ctrl", "j", "window --swap south")
-- ymap("ctrl", "k", "window --swap north")
-- ymap("ctrl", "l", "window --swap east")
--
-- ymap("option", "k", "window --insert north")
-- ymap("option", "j", "window --insert south")
-- ymap("option", "h", "window --insert west")
-- ymap("option", "l", "window --insert east")
--
-- ymap("-", "window --resize bottom:0:-100")
-- ymap("/", "window --ratio abs:0.5")
-- ymap("s", "window --ratio abs:0.66")
-- ymap("shift", "s", "window --ratio abs:0.33")
-- ymap("shift", "=", "window --resize bottom:0:100")
--
-- ymap("=", "space --balance")
-- ymap("r", "space --rotate 90")
-- ymap(",", "space --layout float")
-- ymap(".", "space --layout bsp")
--
-- ymap("1", "window --space 1")
-- ymap("2", "window --space 2")
-- ymap("3", "window --space 3")
-- ymap("4", "window --space 4")
-- ymap("5", "window --space 5")
--
-- -- hmap("k", "window --focus north")
-- -- hmap("j", "window --focus south")
-- -- hmap("h", "window --focus west")
-- -- hmap("l", "window --focus east")
--
-- hmap("f", "window --toggle float")
-- hmap("s", "window --toggle split")
--
-- hmap("p", {
--   "window --toggle sticky",
--   "window --grid 6:6:2:1:2:4"
-- })
