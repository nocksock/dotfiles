-- Monitor Configuration

local M = {}

-- Monitor identifiers
M.LAPTOP = "Samsung Display Corp. ATNA40CU05-0"
M.DELL = "Dell Inc. DELL U2515H 9X2VY5C71BTL"
M.LG = "LG Electronics LG ULTRAWIDE 0x00012CF1"
M.EXTERNAL = M.DELL

hl.monitor({
    output   = "HDMI-A-1",
    mode     = "preferred",
    position = "0x0",
    scale    = 1.0,
})

hl.monitor({
    output   = "DP-3",
    mode     = "preferred",
    position = "0x0",
    scale    = 1.0,
})

hl.monitor({
    output   = "eDP-1",
    mode     = "preferred",
    position = "560x1440",
    scale    = 1.33,
})

hl.monitor({
    output   = "eDP-2",
    mode     = "preferred",
    position = "-2160x720",
    scale    = 1.33,
})

-- Fallback for other monitors
hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = "auto",
})

return M
