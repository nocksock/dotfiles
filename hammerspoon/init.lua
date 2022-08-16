local fennel = require("fennel")
table.insert(package.loaders or package.searchers, fennel.searcher)

HOME = os.getenv("HOME")
HYPER = { "cmd", "ctrl", "shift", "option" }
BREW = "/opt/homebrew/bin/"

P = function(...)
  print(hs.inspect(table.pack(...)))
  return ...
end

local function reload_config(files)
  local do_reload = false
  for _, file in pairs(files) do
    if file:sub(-4) == ".lua" then
      do_reload = true
    end
  end
  if do_reload then
    hs.reload()
  end
end

local function reload_yabai()
  print(HOME .. "/.yabairc")
  hs.task.new(HOME .. "/.yabairc", nil, function(_, ...)
    hs.alert.show("ran .yabairc")
    print("stream", hs.inspect(table.pack(...)))
    return true
  end)
end

hs.pathwatcher.new(HOME .. "/.hammerspoon/", reload_config):start()
hs.pathwatcher.new(HOME .. "/personal/dotfiles/.yabairc", reload_yabai):start()

hs.alert.show("Config loaded")

require('applauncher')
require('yabai')
require('kitty_quake')
require("fnl/test")
