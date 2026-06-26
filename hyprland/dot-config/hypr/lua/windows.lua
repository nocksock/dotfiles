-- Window Rules

local theme = require("lua.theme")

-- Fullscreen border styling
hl.window_rule({
    name  = "fullscreen-border",
    match = { fullscreen = true },
    border_color = {
        colors = {
            theme.alpha(theme.COLOR.GREY_950, 255),
            theme.alpha(theme.COLOR.GREY_950, 255),
        },
        angle = 90,
    },
    border_size  = theme.BORDER_SIZE_BLOCK,
})


-- Block from screen capture
hl.window_rule({
    name  = "1password-no-record",
    match = { title = "1Password" },
    suppress_event = "screenrecord",
})

hl.window_rule({
    name  = "fastmail-no-record",
    match = { title = "^chrome-app\\.fastmail" },
    suppress_event = "screenrecord",
})

hl.window_rule({
    name  = "discord-no-record",
    match = { title = "^Discord$" },
    suppress_event = "screenrecord",
})

hl.window_rule({
    name  = "cinny-no-record",
    match = { title = "^Cinny$" },
    suppress_event = "screenrecord",
})

hl.window_rule({
    name  = "whatsapp-no-record",
    match = { title = "^WhatsApp Web$" },
    suppress_event = "screenrecord",
})

hl.window_rule({
    name  = "teams-no-record",
    match = { title = "Microsoft Teams" },
    suppress_event = "screenrecord",
})

-- Gradia screenshot editor
hl.window_rule({
    name  = "gradia-float-pin",
    match = { title = "Gradia" },
    float = true,
    pin   = true,
})

hl.window_rule({
    name  = "gradia-size",
    match = { class = "Gradia" },
    float = true,
    size  = "1200 960",
})

-- Float note
hl.window_rule({
    name  = "float-note",
    match = { class = "float-note" },
    float = true,
    pin   = true,
})

hl.window_rule({
    name  = "fullscreen-internal-client",
    match = { fullscreen_state_internal = 1, fullscreen_state_client = 2 },
    border_color = theme.COLOR.GREY_300,
    border_size  = theme.BORDER_SIZE_THICK,
})

hl.window_rule({
    name  = "fullscreen-internal2-client",
    match = { fullscreen_state_internal = 2, fullscreen_state_client = 2 },
    border_color = theme.COLOR.GREY_100,
    border_size  = theme.BORDER_SIZE_THICK,
})

-- GTK portal
hl.window_rule({
    name  = "gtk-portal",
    match = { class = "xdg-desktop-portal-gtk" },
    float = true,
    size  = "800 600",
})

-- Bluetui
hl.window_rule({
    name  = "bluetui",
    match = { title = "*bluetui*" },
    float = true,
    size  = "800 600",
})

-- Dmenu
hl.window_rule({
    name  = "dmenu",
    match = { class = "^dmenu$" },
    float = true,
})

hl.window_rule({
    name  = "noctalia",
    match = { 
        class = "^dev.noctalia.noctalia-qs$"
    },
    float = true,
})


-- 1Password
hl.window_rule({
    name  = "1password-float",
    match = { title = "^1Password$" },
    float = true,
})

-- Pavucontrol
hl.window_rule({
    name  = "pavucontrol",
    match = { class = "^pavucontrol$" },
    float = true,
    size  = "960 800",
})

-- Nautilus Previewer
hl.window_rule({
    name  = "nautilus-previewer",
    match = { class = "^NautilusPreviewer$" },
    float = true,
    size  = "1200 960",
})

-- Livebook
hl.window_rule({
    name  = "livebook",
    match = { title = ".*Livebook$" },
    fullscreen_state = "0 2",
})

-- float.md
hl.window_rule({
    name  = "floatmd",
    match = { class = "float.md" },
    float = true,
    pin   = false,
    size  = "1200 960",
})

