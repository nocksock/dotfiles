-- Look and Feel Configuration

local theme = require("lua.theme")

hl.config({
    general = {
        gaps_in  = theme.SPACE_MD,
        gaps_out = theme.SPACE_LG,
        border_size = theme.BORDER_SIZE_DEFAULT,

        col = {
            active_border   = { colors = {theme.COLOR_BORDER_ACTIVE, theme.COLOR_BORDER_ACTIVE}, angle = 90 },
            inactive_border = { colors = {theme.COLOR_BORDER_INACTIVE, theme.COLOR_BORDER_INACTIVE}, angle = 90 },
        },

        resize_on_border = true,
        allow_tearing = false,
        layout = "dwindle",
    },

    decoration = {
        rounding       = 8,
        rounding_power = 8,

        active_opacity   = 1.0,
        inactive_opacity = 1.0,
        dim_inactive     = true,
        dim_strength     = 0.1,
        dim_special      = 0.25,

        shadow = {
            enabled      = true,
            range        = 2,
            render_power = 2,
            offset       = {theme.SHADOW_OFFSET_X, theme.SHADOW_OFFSET_Y},
            sharp        = true,
            color        = "rgba(0,0,0,0.3)",
        },

        blur = {
            enabled = false,
        },
    },

    animations = {
        enabled = true,
    },

    dwindle = {
        -- pseudotile     = true,
        preserve_split = true,
    },

    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo   = true,
    },
})

-- Animation curves
hl.curve("easeOutExpo", { type = "bezier", points = { {0.16, 1}, {0.3, 1} } })
hl.curve("easeOutQuad", { type = "bezier", points = { {0.25, 0.46}, {0.45, 0.94} } })

-- Animations
hl.animation({ leaf = "workspaces",         enabled = false, speed = 0,   bezier = "default",    style = "slidefade" })
hl.animation({ leaf = "specialWorkspaceIn", enabled = true,  speed = 1.5, bezier = "default",    style = "slidefadevert" })
hl.animation({ leaf = "specialWorkspaceOut",enabled = true,  speed = 2,   bezier = "default",    style = "slidefadevert" })
hl.animation({ leaf = "windows",            enabled = true,  speed = 1,   bezier = "default",    style = "popin" })
hl.animation({ leaf = "windowsIn",          enabled = true,  speed = 2,   bezier = "easeOutExpo", style = "slide 20%" })
hl.animation({ leaf = "windowsOut",         enabled = true,  speed = 1,   bezier = "easeOutQuad", style = "slide 20%" })
hl.animation({ leaf = "border",             enabled = true,  speed = 2,   bezier = "default" })
hl.animation({ leaf = "fade",               enabled = true,  speed = 2,   bezier = "default" })
hl.animation({ leaf = "layers",             enabled = true,  speed = 2,   bezier = "default" })
