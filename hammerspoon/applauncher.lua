local utils = require("utils")

local apps = hs.hotkey.modal.new({ "cmd", "control", "shift", "option" }, ";")

function apps:entered()
  hs.alert.show("press key")
end

function apps:exited()
  hs.alert.closeAll()
end

apps:bind("", "escape", function()
  apps:exit()
end)

local launch = utils.modalLauncher(apps)

apps:bind("", "t", "Kitty", launch("kitty"))
apps:bind("", "v", "Visual Studio Code", launch("Visual Studio Code"))
apps:bind("", "c", "Chrome", launch("Google Chrome"))
apps:bind("", "f", "Firefox", launch("Firefox"))
apps:bind("", "s", "Safari", launch("Safari"))
apps:bind("", "p", "Spotify", launch("Spotify"))
apps:bind("", "g", "Things", launch("Things3"))
apps:bind("", "n", "Obsidian", launch("Obsidian"))
apps:bind("", "m", "Mail", launch("Mail"))
apps:bind("", "o", "Discord", launch("Discord"))
apps:bind("", "r", function ()
  apps:exited()

  hs.reload()
  hs.alert("Config loaded")
end)

