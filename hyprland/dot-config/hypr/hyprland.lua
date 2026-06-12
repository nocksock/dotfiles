-- Hyprland Lua Configuration

-- Load theme first (other modules depend on it)
require("lua.theme")

-- Core configuration
require("lua.config")
require("lua.monitors")
require("lua.input")

-- Window and workspace rules
require("lua.windows")
require("lua.workspaces")

-- Keybindings
require("lua.binds")

-- Autostart (should be last)
require("lua.autostart")
