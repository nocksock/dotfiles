-- Monitor Configuration

local M = {}

-- Monitor identifiers
M.LAPTOP = "Samsung Display Corp. ATNA40CU05-0"
M.DELL = "Dell Inc. DELL U2515H 9X2VY5C71BTL"
M.LG = "LG Electronics LG ULTRAWIDE 0x00012CF1"
M.EDK = "NEC Corporation EA273WMi 77307568NB"
M.EXTERNAL = M.LG

-- hl.monitor({
--     output   = "",
--     mode     = "preferred",
--     position = "auto",
--     scale    = "auto",
-- })

hl.monitor({
    output   = "desc:" .. M.LAPTOP,
    mode     = "preferred",
    position = "3440x900",
    scale    = 1.33,
})


hl.monitor({
    output   = "desc:" .. M.DELL,
    mode     = "preferred",
    position = "auto-center-left",
    scale    = 1,
    transform = 3
})

-- LG ultrawide: connected to the laptop's HDMI port, which is wired to the
-- NVIDIA dGPU (card1-HDMI-A-1). Hyprland renders on AMD and copies this output
-- to the dGPU, so the dGPU stays powered while this display is attached.
-- NOTE: daisy-chaining the LG off the Dell over the USB4/TB3 dock did NOT work --
-- MST payload allocation over the DP tunnel fails (DPIA / -EIO in dmesg).
-- Dedicated HDMI link, so no MST bandwidth sharing; preferred = native 3440x1440@60.
hl.monitor({
    output   = "desc:" .. M.LG,
    mode     = "preferred",
    position = "0x0",
    scale    = 1,
})


function M.is_connected(name)
    local monitors = hl.get_monitors()
    for _, monitor in ipairs(monitors) do
        if monitor.description:match(name) then
            return true
        end
    end
    return false
end


return M

