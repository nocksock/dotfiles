-- Input Configuration

hl.config({
    input = {
        kb_layout  = "eu",
        kb_variant = "",
        kb_model   = "",
        kb_rules   = "",
        kb_options = "ctrl:nocaps",
        -- kb_options = "ctrl:nocaps,altwin:swap_lalt_lwin",

        follow_mouse     = 2,
        numlock_by_default = true,
        sensitivity      = 0.2,
        natural_scroll   = true,

        touchpad = {
            natural_scroll       = true,
            tap_to_click         = true,
            disable_while_typing = true,
            scroll_factor        = 1.0,
            drag_3fg             = true,
        },
    },

    binds = {
        hide_special_on_workspace_change = true,
    },

    cursor = {
        persistent_warps         = true,
        warp_on_change_workspace = true,
        -- NVIDIA: avoid the stale hardware-cursor plane left by GNOME/GDM
        -- showing as a frozen second cursor. Software cursors are composited
        -- into Hyprland's own framebuffer, so no separate HW plane can ghost.
        no_hardware_cursors      = true,
    },
})

-- Per-device configuration
hl.device({
    name           = "kensington-expert-wireless-tb-mouse",
    natural_scroll = false,
    sensitivity    = -0.8,
})
