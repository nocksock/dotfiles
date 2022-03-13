vim.o.guifont = "JetBrains Mono:h15"
vim.cmd("syntax on")

local bg = function(bg)
	vim.cmd("set background=" .. bg)
end

local function theme(scheme)
	vim.cmd("colorscheme " .. scheme)
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
