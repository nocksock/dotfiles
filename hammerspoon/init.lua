local fennel = require("fennel")
table.insert(package.loaders or package.searchers, fennel.searcher)

HYPER = { "cmd", "ctrl", "shift", "option" }
BREW = "/opt/homebrew/bin/"

P = function(...)
  print(hs.inspect(table.pack(...)))
end

local function reloadConfig(files)
  local doReload = false
  for _, file in pairs(files) do
    if file:sub(-4) == ".lua" then
      doReload = true
    end
  end
  if doReload then
    hs.reload()
  end
end

hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.alert.show("Config loaded")

require('applauncher')
require('yabai')
require("fnl/test")
