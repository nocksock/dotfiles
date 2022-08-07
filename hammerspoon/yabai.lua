local yabai = hs.hotkey.modal.new({ "cmd", "control", "shift", "option" }, "y")
local task = require('utils').task

local function run(cmd)
  hs.task.new("/opt/homebrew/bin/yabai", nil, function(_, ...)
    print("stream", hs.inspect(table.pack(...)))
    return true
  end, cmd):start()
end

local function msg(cmd)
  return function() run(cmd) end
end

function yabai:entered()
  msg({ "-m", "config", "window_border_width", "5" })()
  hs.alert.show("yabai", nil, hs.screen.allScreens(), true)
end

function yabai:exited()
  msg({ "-m", "config", "window_border_width", "2" })()
  hs.alert.closeAll()
end

yabai:bind("", "escape", function()
  yabai:exit()
end)

yabai:bind("", "return", function()
  yabai:exit()
end)


yabai:bind("", "f", msg({ "-m", "window", "--toggle", "zoom-parent" }))
yabai:bind("", "F", msg({ "-m", "window", "--toggle", "zoom-fullscreen" }))
yabai:bind("shift", "r", task("/Users/nilsriedemann/.yabairc"))
yabai:bind("", "x", function()
  msg({ "-m", "window", "--close" })()
  msg({ "-m", "window", "--focus", "recent" })()
end)

yabai:bind("", "h", msg({ "-m", "window", "--focus", "west" }))
yabai:bind("", "j", msg({ "-m", "window", "--focus", "south" }))
yabai:bind("", "k", msg({ "-m", "window", "--focus", "north" }))
yabai:bind("", "l", msg({ "-m", "window", "--focus", "east" }))
yabai:bind("ctrl", "h", msg({ "-m", "window", "--swap", "west" }))
yabai:bind("ctrl", "j", msg({ "-m", "window", "--swap", "south" }))
yabai:bind("ctrl", "k", msg({ "-m", "window", "--swap", "north" }))
yabai:bind("ctrl", "l", msg({ "-m", "window", "--swap", "east" }))

yabai:bind("option", "up", msg({ "-m", "window", "--insert", "north" }))
yabai:bind("option", "down", msg({ "-m", "window", "--insert", "south" }))
yabai:bind("option", "left", msg({ "-m", "window", "--insert", "west" }))
yabai:bind("option", "right", msg({ "-m", "window", "--insert", "east" }))

yabai:bind("", "-", msg({ "-m", "window", "--resize", "bottom:0:-100" }))
yabai:bind("", "/", msg({ "-m", "window", "--ratio", "abs:0.5" }))
yabai:bind("", "s", msg({ "-m", "window", "--ratio", "abs:0.66" }))
yabai:bind("shift", "s", msg({ "-m", "window", "--ratio", "abs:0.33" }))

yabai:bind("shift", "=", msg({ "-m", "window", "--resize", "bottom:0:100" }))

yabai:bind("", "=", msg({ "-m", "space", "--balance" }))
yabai:bind("", "r", msg({ "-m", "space", "--rotate", "90" }))
yabai:bind("", ",", msg({ "-m", "space", "--layout", "float" }))
yabai:bind("", ".", msg({ "-m", "space", "--layout", "bsp" }))

yabai:bind("", "1", msg({ "-m", "window", "--space", "1" }))
yabai:bind("", "2", msg({ "-m", "window", "--space", "2" }))
yabai:bind("", "3", msg({ "-m", "window", "--space", "3" }))
yabai:bind("", "4", msg({ "-m", "window", "--space", "4" }))
yabai:bind("", "5", msg({ "-m", "window", "--space", "5" }))

hs.hotkey.bind(HYPER, "up", msg({ "-m", "window", "--warp", "north" }))
hs.hotkey.bind(HYPER, "down", msg({ "-m", "window", "--warp", "south" }))
hs.hotkey.bind(HYPER, "left", msg({ "-m", "window", "--warp", "west" }))
hs.hotkey.bind(HYPER, "right", msg({ "-m", "window", "--warp", "east" }))
hs.hotkey.bind(HYPER, "k", msg({ "-m", "window", "--focus", "north" }))
hs.hotkey.bind(HYPER, "j", msg({ "-m", "window", "--focus", "south" }))
hs.hotkey.bind(HYPER, "h", msg({ "-m", "window", "--focus", "west" }))
hs.hotkey.bind(HYPER, "l", msg({ "-m", "window", "--focus", "east" }))

hs.hotkey.bind(HYPER, "1", msg({ "-m", "space", "--focus", "1" }))
hs.hotkey.bind(HYPER, "2", msg({ "-m", "space", "--focus", "2" }))
hs.hotkey.bind(HYPER, "3", msg({ "-m", "space", "--focus", "3" }))
hs.hotkey.bind(HYPER, "4", msg({ "-m", "space", "--focus", "4" }))
hs.hotkey.bind(HYPER, "5", msg({ "-m", "space", "--focus", "5" }))

hs.hotkey.bind(HYPER, "n", msg({ "-m", "space", "--focus", "next" }))
hs.hotkey.bind(HYPER, "p", msg({ "-m", "space", "--focus", "prev" }))

hs.hotkey.bind(HYPER, "f", msg({ "-m", "window", "--toggle", "float" }))
hs.hotkey.bind(HYPER, "s", msg({ "-m", "window", "--toggle", "split" }))

hs.hotkey.bind(HYPER, "6", msg({ "-m", "space", "--display", "recent" }))
