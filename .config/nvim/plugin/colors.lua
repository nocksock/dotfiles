vim.o.guifont = "JetBrains Mono:h15"
vim.cmd("syntax on")
local bg = function(bg) vim.g.background = bg end

local function theme(theme)
	vim.cmd("colorscheme " .. theme)
end

function ThemeBloop()
	bg "dark"
	theme "bloop"
end

function ThemeGhash()
	bg "dark"
	theme "ghash"
end

function ThemePaperColor()
	bg "light"
	theme "PaperColor"
end

ThemeBloop()
