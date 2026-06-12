-- Input Configuration

hl.config({
    input = {
        kb_layout  = "eu",
        kb_variant = "",
        kb_model   = "",
        kb_rules   = "",
        -- kb_options = "ctrl:nocaps",
        kb_options = "ctrl:nocaps,altwin:swap_lalt_lwin",

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
    },
})

-- Per-device configuration
hl.device({
    name           = "kensington-expert-wireless-tb-mouse",
    natural_scroll = false,
    sensitivity    = -0.8,
})
