HOME = os.getenv("HOME")
HYPER = { "cmd", "ctrl", "shift", "option" }
BREW = "/opt/homebrew/bin/"

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
  hs.task.new(HOME .. "/.yabairc", nil, function(_, ...)
    hs.alert.show("ran .yabairc")
    print("stream", hs.inspect(table.pack(...)))
    return true
  end)
end

hs.pathwatcher.new(HOME .. "/.hammerspoon/", reload_config):start()
hs.pathwatcher.new(HOME .. "/code/dotfiles/.yabairc", reload_yabai):start()

hs.alert.show("Config loaded")

require('applauncher')
require('yabai')
require('kitty_quake')
