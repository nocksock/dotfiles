-- Theme: Colors, Spacing, Borders
-- Returns a table with all theme values

local M = {}

-- Colors (palette)
M.COLOR = {
    YELLOW_50 = "rgba(FCFCEDFF)",
    YELLOW_100 = "rgba(FBF8D4FF)",
    YELLOW_200 = "rgba(FBF18FFF)",
    YELLOW_300 = "rgba(FCE531FF)",
    YELLOW_400 = "rgba(F1CC00FF)",
    YELLOW_500 = "rgba(E7B400FF)",
    YELLOW_600 = "rgba(C88C00FF)",
    YELLOW_700 = "rgba(A06300FF)",
    YELLOW_800 = "rgba(884B04FF)",
    YELLOW_900 = "rgba(733D14FF)",
    YELLOW_950 = "rgba(431F0DFF)",
    BLUE_50 = "rgba(EDF7FAFF)",
    BLUE_100 = "rgba(D5EEF5FF)",
    BLUE_200 = "rgba(B1E1F1FF)",
    BLUE_300 = "rgba(87CCEAFF)",
    BLUE_400 = "rgba(4AADE7FF)",
    BLUE_500 = "rgba(188CE2FF)",
    BLUE_600 = "rgba(1372C7FF)",
    BLUE_700 = "rgba(1B66B3FF)",
    BLUE_800 = "rgba(0E4E90FF)",
    BLUE_900 = "rgba(184275FF)",
    BLUE_950 = "rgba(132A47FF)",
    GREY_50 = "rgba(F7F7F7FF)",
    GREY_100 = "rgba(E9E9E9FF)",
    GREY_200 = "rgba(CCCDCDFF)",
    GREY_300 = "rgba(B1B1B2FF)",
    GREY_400 = "rgba(969798FF)",
    GREY_500 = "rgba(7C7D7FFF)",
    GREY_600 = "rgba(636466FF)",
    GREY_700 = "rgba(4B4D4EFF)",
    GREY_800 = "rgba(343638FF)",
    GREY_900 = "rgba(242628FF)",
    GREY_950 = "rgba(1D1F21FF)",
    RED_50 = "rgba(FDF2F3FF)",
    RED_100 = "rgba(FCE3E4FF)",
    RED_200 = "rgba(FCCBCBFF)",
    RED_300 = "rgba(FAA6A4FF)",
    RED_400 = "rgba(F4716FFF)",
    RED_500 = "rgba(EC4948FF)",
    RED_600 = "rgba(DB282DFF)",
    RED_700 = "rgba(B91C1EFF)",
    RED_800 = "rgba(991B1AFF)",
    RED_900 = "rgba(7D201FFF)",
    RED_950 = "rgba(430D0FFF)",
    ORANGE_50 = "rgba(FEF7F0FF)",
    ORANGE_100 = "rgba(FEEDDBFF)",
    ORANGE_200 = "rgba(FBD7B5FF)",
    ORANGE_300 = "rgba(FCB982FF)",
    ORANGE_400 = "rgba(F88F42FF)",
    ORANGE_500 = "rgba(F57624FF)",
    ORANGE_600 = "rgba(E55E1DFF)",
    ORANGE_700 = "rgba(BE451AFF)",
    ORANGE_800 = "rgba(9A341AFF)",
    ORANGE_900 = "rgba(7C2C1CFF)",
    ORANGE_950 = "rgba(43140EFF)",
    GREEN_50 = "rgba(F8FDECFF)",
    GREEN_100 = "rgba(E5F6D2FF)",
    GREEN_200 = "rgba(CFF2B3FF)",
    GREEN_300 = "rgba(9AE28AFF)",
    GREEN_400 = "rgba(88D06AFF)",
    GREEN_500 = "rgba(7AC466FF)",
    GREEN_600 = "rgba(4EA646FF)",
    GREEN_700 = "rgba(318034FF)",
    GREEN_800 = "rgba(23662DFF)",
    GREEN_900 = "rgba(20562BFF)",
    GREEN_950 = "rgba(0C2F19FF)",
    LILAC_50 = "rgba(F5F4FAFF)",
    LILAC_100 = "rgba(EAEAF7FF)",
    LILAC_200 = "rgba(DADCF5FF)",
    LILAC_300 = "rgba(C4C7EDFF)",
    LILAC_400 = "rgba(A8ADDFFF)",
    LILAC_500 = "rgba(8C94CBFF)",
    LILAC_600 = "rgba(6F79B2FF)",
    LILAC_700 = "rgba(5B6597FF)",
    LILAC_800 = "rgba(49527BFF)",
    LILAC_900 = "rgba(384060FF)",
    LILAC_950 = "rgba(21283BFF)",
    STONE_50 = "rgba(FAF9F7FF)",
    STONE_100 = "rgba(F5F0EBFF)",
    STONE_200 = "rgba(E8DFD6FF)",
    STONE_300 = "rgba(D5C8BCFF)",
    STONE_400 = "rgba(B8A99BFF)",
    STONE_500 = "rgba(9A8B7DFF)",
    STONE_600 = "rgba(7D6E61FF)",
    STONE_700 = "rgba(635649FF)",
    STONE_800 = "rgba(4D4139FF)",
    STONE_900 = "rgba(3B312AFF)",
    STONE_950 = "rgba(231E1AFF)",
}

-- Spacing
M.spacing_base = 4
function M.space(n)
    return M.spacing_base * n
end

-- Border sizes
M.border_base = 2
function M.border(n)
    return M.border_base * n
end

-- Replace the alpha channel of an rgba(RRGGBBAA) color string.
-- a is an integer 0-255 (255 = opaque, 128 = 50% transparent).
function M.alpha(color, a)
    return (color:gsub("(rgba%(%x%x%x%x%x%x)%x%x%)", string.format("%%1%02X)", a)))
end

-- Semantic spacing
M.SPACE_XS = M.space(1)
M.SPACE_SM = M.space(2)
M.SPACE_MD = M.space(4)
M.SPACE_LG = M.space(12)
M.SPACE_XL = M.space(24)
M.SPACE_2XL = M.space(36)
M.SPACE_3XL = M.space(48)
M.SPACE_4XL = M.space(72)

-- Semantic borders
M.BORDER_SIZE_DEFAULT = M.border(2)
M.BORDER_SIZE_THIN = 1
M.BORDER_SIZE_THICK = M.border(3)
M.BORDER_SIZE_FULLSCREEN = M.border(16)

-- Semantic colors
M.COLOR_BORDER_ACTIVE = M.COLOR.GREEN_400
M.COLOR_BORDER_INACTIVE = M.COLOR.STONE_800

-- Shadow
M.SHADOW_OFFSET_X = M.space(3)
M.SHADOW_OFFSET_Y = M.space(3)

return M
