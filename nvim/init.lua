-- welcome to my nvim config.
vim.o.backup = true -- enable backups
vim.o.backupskip = '/tmp/*,/private/tmp/*' -- Make Vim able to edit crontab files again.
vim.o.backupdir = '/tmp'
vim.o.breakindent = true -- wrapped lines appear indendet
vim.o.clipboard = 'unnamed'
vim.o.fillchars = 'eob:⸱'
vim.o.hidden = true -- makes it possible to leave a buffer if it has unsaved changes. `gd` etc fail horribly in those cases.
vim.o.completeopt = 'menu,menuone,noselect,longest,preview'
vim.o.expandtab = true
vim.o.cursorline = false -- Highlight the line of in which the cursor is present (or not)
vim.o.foldenable = true
vim.o.formatoptions = 'qrn1j' -- format options when writing, joining lines or `gq` see  :he fo-table for meanings
vim.o.gdefault = true -- add g flag by default for :substitutions
vim.o.ignorecase = true -- ignore case by default - unless using uppercase/lowercase via smartcase
vim.o.list = true -- Show invisible characters
vim.o.listchars = 'tab:->,eol:¬,trail:-,extends:↩,precedes:↪' -- define characters for invisible characters
vim.o.mouse = 'a' -- enable scrolling and selecting with mouse
vim.o.nu = true
vim.o.rnu = true -- show *HYBRID* line numbers, relative line numbers + current line number
vim.o.pumheight = 10 -- limit popupmenu to 10 lines
vim.o.scrolloff = 2 -- always have 2 lines more visible when reaching top/end of a window when scrolling
vim.o.shell = '/bin/zsh' -- set default shell for :shell
vim.o.shiftround = true -- When at 3 spaces and I hit >>, go to 4, not 5.
vim.o.updatetime = 250
vim.o.shiftwidth = 2
vim.o.showmatch = true -- Highlight matching bracket
vim.o.signcolumn = 'yes'
vim.o.smartcase = true -- ignore 'ignorecase' when search contains uppercase characters
vim.o.softtabstop = 2
vim.o.splitbelow = true -- When on, splitting a window will put the new window below the current one
vim.o.tabstop = 2
vim.o.termguicolors = true -- enable 24bit colors
vim.o.textwidth = 80
vim.o.undofile = true
vim.o.wrap = false -- don't wrap text around when the window is too small
vim.o.wildignore = table.concat({
	'.DS_Store',
	'**/.git/*',
	'*.jpg,*.bmp,*.gif,*.png,*.jpeg', -- ignore binary images
	'**/coverage/*',
	'**/node_modules/*',
	'**/android/*',
	'**/.git/*',
	'**/tmp/*',
}, ',')
vim.o.path = vim.o.path .. ',**'
vim.g.colors_name = 'tokyonight'
vim.o.background = 'dark'
vim.o.guifont = 'JetBrains Mono:h16'

-- vim.o.wildmode = 'longest,list,full'

vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

vim.g.netrw_altfile = 1 -- make CTRL-^ ignore netrw buffers
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 33

vim.g.db_ui_force_echo_notifications = 1

-- TODO convert to proper lua
vim.cmd([[
	filetype plugin on

	augroup snock
	au!
	autocmd TermOpen * setlocal nonumber norelativenumber
	autocmd TermOpen * startinsert
	autocmd TermOpen * nnoremap <buffer> <C-c> i<C-c>
	augroup END!
]])

P = function(v)
	print(vim.inspect(v))
	return v
end

if pcall(require, 'plenary') then
	RELOAD = require('plenary.reload').reload_module

	R = function(name)
		RELOAD(name)
		return require(name)
	end
end

local group = vim.api.nvim_create_augroup('togglelistinsertleave', { clear = true })
vim.api.nvim_create_autocmd('insertenter', {
	callback = function()
		vim.o.rnu = false
		vim.o.list = true
	end,
	group = group,
})
vim.api.nvim_create_autocmd('insertleave', {
	callback = function()
		vim.o.rnu = true
		vim.o.list = false
	end,
	group = group,
})
