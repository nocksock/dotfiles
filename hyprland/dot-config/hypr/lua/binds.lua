-- Keybindings
-- keynames https://github.com/xkbcommon/libxkbcommon/blob/master/include/xkbcommon/xkbcommon-keysyms.h

local theme = require("lua.theme")

-- Application launchers
hl.bind("SUPER + Return", hl.dsp.exec_cmd("kitty"))
hl.bind("SUPER + Space", hl.dsp.exec_cmd("vicinae toggle"))
hl.bind("SUPER + SHIFT + Space", hl.dsp.exec_cmd("fuzzel"))
hl.bind("SUPER + CTRL + Space", hl.dsp.exec_cmd("vicinae vicinae://extensions/vicinae/core/search-emojis"))

-- Utilities and apps
hl.bind("SUPER + CTRL + M", hl.dsp.exec_cmd("kitty --class float.md -e wiremix"))
hl.bind("SUPER + D", hl.dsp.exec_cmd("~/.local/bin/nox-menu"))
hl.bind("SUPER + Backslash", hl.dsp.exec_cmd("1password"))
hl.bind("SUPER + CTRL + Comma", hl.dsp.exec_cmd("obsidian"))
hl.bind("SUPER + CTRL + D", hl.dsp.exec_cmd("kitty lazydocker"))
hl.bind("SUPER + Delete", hl.dsp.exec_cmd("makoctl dismiss --all"))
hl.bind("SUPER + ALT + C", hl.dsp.exec_cmd("vicinae vicinae://extensions/vicinae/clipboard/history"))

-- Notes
hl.bind("SUPER + N", hl.dsp.exec_cmd("~/.local/bin/nox-menu notes"))
hl.bind("SUPER + SHIFT + N", hl.dsp.exec_cmd("kitty -1 -e vim ~/now"))
hl.bind("SUPER + CTRL + N", hl.dsp.exec_cmd("~/.local/bin/nox-menu notes '!!'"))

-- Window management
hl.bind("SUPER + Q", hl.dsp.window.close())

-- Focus with vim keys
hl.bind("SUPER + H", hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER + L", hl.dsp.focus({ direction = "right" }))
hl.bind("SUPER + K", hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER + J", hl.dsp.focus({ direction = "down" }))

-- With cursor keys (usually when I use one of my split keyboards)
hl.bind("SUPER + Left", hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER + Right", hl.dsp.focus({ direction = "right" }))
hl.bind("SUPER + Up", hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER + Down", hl.dsp.focus({ direction = "down" }))

-- Move windows with vim keys
hl.bind("SUPER + CTRL + H", hl.dsp.window.move({ direction = "left" }))
hl.bind("SUPER + CTRL + L", hl.dsp.window.move({ direction = "right" }))
hl.bind("SUPER + CTRL + K", hl.dsp.window.move({ direction = "up" }))
hl.bind("SUPER + CTRL + J", hl.dsp.window.move({ direction = "down" }))

-- Submap for layout operations
hl.bind("SUPER + O", hl.dsp.submap("launch_submap"))

hl.define_submap("launch_submap", "reset", function()
    hl.bind("M", hl.dsp.exec_cmd("hyprctl dispatch workspace layout master"))
    hl.bind("H", hl.dsp.layout("preselect l"))
    hl.bind("L", hl.dsp.layout("preselect r"))
    hl.bind("J", hl.dsp.layout("preselect b"))
    hl.bind("K", hl.dsp.layout("preselect u"))
    hl.bind("X", hl.dsp.layout("swapsplit"))
    hl.bind("Escape", hl.dsp.submap("reset"))
end)

-- Submap for layout operations
hl.bind("SUPER + G", hl.dsp.submap("gaps"))

hl.define_submap("gaps", "reset", function()
    hl.bind("1", function() 
        hl.config({general = { 
            gaps_in = 0,
            gaps_out = 0
        }}) end)
    hl.bind("Escape", hl.dsp.submap("reset"))
end)


-- Monitor management
hl.bind("SUPER + SHIFT + H", hl.dsp.focus({ monitor = "left" }))
hl.bind("SUPER + SHIFT + L", hl.dsp.focus({ monitor = "right" }))
hl.bind("SUPER + SHIFT + K", hl.dsp.focus({ monitor = "up" }))
hl.bind("SUPER + SHIFT + J", hl.dsp.focus({ monitor = "down" }))

-- Move window to monitor
hl.bind("SUPER + SHIFT + CTRL + H", hl.dsp.window.move({ monitor = "left" }))
hl.bind("SUPER + SHIFT + CTRL + L", hl.dsp.window.move({ monitor = "right" }))
hl.bind("SUPER + SHIFT + CTRL + K", hl.dsp.window.move({ monitor = "up" }))
hl.bind("SUPER + SHIFT + CTRL + J", hl.dsp.window.move({ monitor = "down" }))

-- Fullscreen and floating
hl.bind("SUPER + F", hl.dsp.window.fullscreen({ mode = 1, }))
hl.bind("SUPER + SHIFT + F", hl.dsp.window.fullscreen_state({ internal = 3, client = 0 }))
hl.bind("SUPER + CTRL + F", hl.dsp.window.fullscreen_state({ internal = -1, client = 2 }))

hl.bind("SUPER + C", hl.dsp.window.center())

hl.bind("SUPER + V", function()
    hl.dispatch(hl.dsp.window.float({ action = "toggle" }))
    hl.dispatch(hl.dsp.window.center())
end)
hl.bind("SUPER + CTRL + V", hl.dsp.window.pin())

hl.bind("SUPER + M", function()
    hl.dispatch(hl.dsp.window.float({ action = "set" }))
    hl.dispatch(hl.dsp.window.resize({ x = "1536", y = "1080" }))
    hl.dispatch(hl.dsp.window.center())
end)

-- Resize window
-- TODO: hl.dsp.window.resize requires both x and y as valid resize values
local resizeUnit = 100;
hl.bind("SUPER + Minus", hl.dsp.window.resize({ x = -resizeUnit, y = 0, relative = true }))
hl.bind("SUPER + Equal", hl.dsp.window.resize({ x = resizeUnit, y = 0, relative = true }))
hl.bind("SUPER + SHIFT + Minus", hl.dsp.window.resize({ x = 0, y = -resizeUnit, relative = true }))
hl.bind("SUPER + SHIFT + Equal", hl.dsp.window.resize({ x = 0, y = resizeUnit, relative = true }))

-- Tiling control
hl.bind("SUPER + R", hl.dsp.layout("togglesplit"))
hl.bind("SUPER + CTRL + R", hl.dsp.layout("splitratio 1.0 exact"))

-- Groups/Tabs
-- hl.bind("SUPER + W", hl.dsp.group({ action = "toggle" }))
-- hl.bind("SUPER + CTRL + W", hl.dsp.group({ action = "moveout" }))
-- hl.bind("SUPER + CTRL + BracketLeft", hl.dsp.group({ action = "movein", direction = "left" }))
-- hl.bind("SUPER + CTRL + BracketRight", hl.dsp.group({ action = "movein", direction = "right" }))
-- hl.bind("SUPER + BracketLeft", hl.dsp.group({ action = "change", direction = "back" }))
-- hl.bind("SUPER + BracketRight", hl.dsp.group({ action = "change", direction = "forward" }))

-- Pseudo-tiling
hl.bind("SUPER + P", hl.dsp.window.pseudo())
hl.bind("SUPER + CTRL + P", hl.dsp.window.fullscreen_state({ internal = -1, client = 2 }))

-- Workspace management
for i = 2, 8 do
    hl.bind("SUPER + " .. i, hl.dsp.focus({ workspace = i }))
    hl.bind("SUPER + CTRL + " .. i, hl.dsp.window.move({ workspace = i }))
end
hl.bind("SUPER + SHIFT + Grave", hl.dsp.focus({ workspace = "9" }))

local monitors = require("lua.monitors")

local notify = function(text)
    hl.notification.create({ timeout = 1000, text = text })
end

hl.bind("SUPER + Grave", function ()
    if monitors.is_connected(monitors.DELL) then
        hl.dispatch(hl.dsp.focus({ workspace = "s1" }))
        local current = hl.get_active_workspace()
        local dell = hl.get_monitor("desc:" .. monitors.DELL)
        local workspace = hl.get_active_workspace(dell)

        if workspace == nil then
            notify("No active workspace on Dell monitor")
            return
        end

        if workspace.name == "9" then
            hl.dispatch(hl.dsp.focus({ workspace = "0" }))
        else
            hl.dispatch(hl.dsp.focus({ workspace = "9" }))
        end

        hl.dispatch(hl.dsp.focus({ workspace = current }))


        -- hl.notification.create({ timeout = 1000, text = active.name })
        -- if active.name == "1" then
        --     hl.dispatch(hl.dsp.focus({ workspace = "2" }))
        -- else
        --     hl.dispatch(hl.dsp.focus({ workspace = "1" }))
        -- end
    end
end)


-- next workspace
hl.bind("SUPER + BracketRight", hl.dsp.focus({ workspace = "+1" }))
hl.bind("SUPER + BracketLeft", hl.dsp.focus({ workspace = "-1" }))

-- Special Workspaces
hl.bind("SUPER + Semicolon", hl.dsp.workspace.toggle_special("term"))
hl.bind("SUPER + CTRL + Semicolon", hl.dsp.window.move({ workspace = "special:term", silent = true }))

hl.bind("SUPER + Comma", hl.dsp.workspace.toggle_special("term"))
hl.bind("SUPER + CTRL + Comma", hl.dsp.window.move({ workspace = "special:term", silent = true }))

hl.bind("SUPER + Period", hl.dsp.workspace.toggle_special("notes"))
hl.bind("SUPER + CTRL + Period", hl.dsp.window.move({ workspace = "special:notes" }))

hl.bind("SUPER + Slash", hl.dsp.workspace.toggle_special("docs"))
hl.bind("SUPER + CTRL + Slash", hl.dsp.window.move({ workspace = "special:docs", silent = true }))


hl.bind("SUPER + Delete", hl.dsp.workspace.toggle_special("hidden"))
hl.bind("SUPER + CTRL + Delete", hl.dsp.window.move({ workspace = "special:hidden", silent = true }))

-- Screenshots
hl.bind("SUPER + SHIFT + 4", hl.dsp.exec_cmd('GRIMBLAST_EDITOR="gradia" grimblast edit area'))
hl.bind("SUPER + SHIFT + 5", hl.dsp.exec_cmd('GRIMBLAST_EDITOR="gradia" grimblast edit screen'))
hl.bind("Print", hl.dsp.exec_cmd("grimblast copy area"))
hl.bind("CTRL + Print", hl.dsp.exec_cmd("grimblast copy screen"))
hl.bind("ALT + Print", hl.dsp.exec_cmd("grimblast copy active"))

-- Screen sharing / mirror
hl.bind("SUPER + SHIFT + P", hl.dsp.exec_cmd([[sh -c 'wl-mirror $(hyprctl -j monitors | jq -r ".[] | select(.focused == true) | .name")']]))

-- Media keys
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1-"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true, repeating = true })

-- Brightness
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl --device=amdgpu_bl1 set +10%"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl --device=amdgpu_bl1 set 10%-"), { locked = true, repeating = true })
hl.bind("SUPER + F8", hl.dsp.exec_cmd("brightnessctl --device=amdgpu_bl1 set 10%"))
hl.bind("SUPER + F9", hl.dsp.exec_cmd("brightnessctl --device=amdgpu_bl1 set 50%"))

-- Media control
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

-- Power management
hl.bind("SUPER + SHIFT + Delete", hl.dsp.exec_cmd("swaylock -f"))
hl.bind("SUPER + SHIFT + Escape", hl.dsp.dpms("off"))

-- System
hl.bind("SUPER + SHIFT + E", hl.dsp.exit())
hl.bind("CTRL + ALT + Delete", hl.dsp.exit())

-- Mouse bindings
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Cursor zoom with scroll
hl.bind("SUPER + mouse_down", hl.dsp.exec_cmd([[hyprctl -q keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor -j | jq '.float * 1.1')]]))
hl.bind("SUPER + mouse_up", hl.dsp.exec_cmd([[hyprctl -q keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor -j | jq '(.float * 0.9) | if . < 1 then 1 else . end')]]))

-- Cursor zoom with keyboard
hl.bind("SUPER + CTRL + Equal", hl.dsp.exec_cmd([[hyprctl -q keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor -j | jq '.float * 1.1')]]), { repeating = true })
hl.bind("SUPER + CTRL + Minus", hl.dsp.exec_cmd([[hyprctl -q keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor -j | jq '(.float * 0.9) | if . < 1 then 1 else . end')]]), { repeating = true })
hl.bind("SUPER + CTRL + 0", hl.dsp.exec_cmd("hyprctl -q keyword cursor:zoom_factor 1"))

-- Lid switch
-- Lock on any lid event.
hl.bind("switch:Lid Switch", hl.dsp.exec_cmd("hyprlock"), { locked = true })
-- Toggle the laptop panel so docking with the lid shut keeps the externals
-- working: closed (switch on) -> disable eDP-2; open (switch off) -> restore it.
-- desc-based via the monitors module so it follows the panel, not a connector name.
local laptop_desc = "desc:" .. require("lua.monitors").LAPTOP
hl.bind("switch:on:Lid Switch",
    hl.dsp.exec_cmd('hyprctl keyword monitor "' .. laptop_desc .. ', disable"'),
    { locked = true })
hl.bind("switch:off:Lid Switch",
    hl.dsp.exec_cmd('hyprctl keyword monitor "' .. laptop_desc .. ', preferred, 3440x900, 1.33"'),
    { locked = true })

hl.bind("SUPER + Tab", function()
    hl.dispatch(hl.dsp.focus({workspace = "+1"}))    -- Change focus to another window
end)
