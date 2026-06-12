-- Autostart and Environment Variables

-- Environment variables
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "12")
hl.env("HYPRCURSOR_THEME", "macOS")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")

-- Permissions
hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")

-- Autostart
hl.on("hyprland.start", function()
    hl.exec_cmd("[workspace 1 silent] kitty")

    -- Scratchpad applications
    hl.exec_cmd("[workspace special:term silent] kitty")
    hl.exec_cmd("[workspace special:term silent] kitty -e nvim ~/now")
    hl.exec_cmd("[workspace special:notes silent] kitty --class scratchpad-notes -e nvim ~/now")

    -- Services
    hl.exec_cmd("darkman run")
    hl.exec_cmd("waybar")
    hl.exec_cmd("vicinae server")
    hl.exec_cmd("mako")
    hl.exec_cmd("hypridle")
end)
