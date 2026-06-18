-- Workspace Rules

local theme = require("lua.theme")
local monitors = require("lua.monitors")

-- Monitor-specific workspaces
hl.workspace_rule({ workspace = "1", monitor = "desc:" .. monitors.EXTERNAL, persistent = true })
hl.workspace_rule({ workspace = "2", monitor = "desc:" .. monitors.EXTERNAL, persistent = true })
hl.workspace_rule({ workspace = "3", monitor = "desc:" .. monitors.EXTERNAL, persistent = true })
hl.workspace_rule({ workspace = "4", monitor = "desc:" .. monitors.LAPTOP,   persistent = true })
hl.workspace_rule({ workspace = "5", monitor = "desc:" .. monitors.LAPTOP,   persistent = true })
hl.workspace_rule({ workspace = "6", monitor = "desc:" .. monitors.LAPTOP,   persistent = true })

-- Gap rules for visible workspaces
hl.workspace_rule({ workspace = "w[v1]",         gaps_in = theme.SPACE_LG, gaps_out = theme.SPACE_MD })
hl.workspace_rule({ workspace = "w[v1]s[true]",  gaps_in = theme.SPACE_LG, gaps_out = theme.SPACE_LG })
hl.workspace_rule({ workspace = "f[0]",          gaps_in = theme.SPACE_LG, gaps_out = theme.SPACE_2XL })
hl.workspace_rule({ workspace = "f[1]",          gaps_out = theme.SPACE_LG })

-- Special workspaces
hl.workspace_rule({ workspace = "name:special:notes",  layout = "master" })
hl.workspace_rule({ workspace = "name:special:term",   layout = "master" })
hl.workspace_rule({ workspace = "name:special:docs", layout = "scrolling" })
hl.workspace_rule({ workspace = "name:special:hidden", layout = "scrolling" })

-- HDMI monitor specific
hl.workspace_rule({ workspace = "w[tv1]s[false]m[HDMI-A-1]", gaps_out = {theme.SPACE_XL, theme.SPACE_4XL} })
hl.workspace_rule({ workspace = "w[tv2]m[HDMI-A-1]",         gaps_in = theme.SPACE_MD, gaps_out = theme.SPACE_LG })
hl.workspace_rule({ workspace = "w[tv3]m[HDMI-A-1]",         gaps_in = theme.SPACE_MD, gaps_out = theme.SPACE_LG })
