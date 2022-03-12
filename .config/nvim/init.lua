--
--  Hi!
--
--    This is my messy nvim configuration
--

local function setWith(mod, options)
	for key, value in pairs(options) do
		mod[key] = value
	end
end

setWith(vim.o, {
	backup = true, -- enable backups
	backupskip = "/tmp/*,/private/tmp/*", -- Make Vim able to edit crontab files again.
	breakindent = true, -- wrapped lines appear indendet
	clipboard = "unnamed",
	completeopt = "menu,menuone,noselect",
	cursorline = true, -- Highlight the line of in which the cursor is present (or not)
	expandtab = true, -- use spaces for indentation by default
	foldenable = true,
	formatoptions = "qrn1j", -- format options when writing, joining lines or `gq` see  :he fo-table for meanings
	gdefault = true, -- add g flag by default for :substitutions
	ignorecase = true, -- ignore case by default - unless using uppercase/lowercase via smartcase
	list = true, -- Show invisible characters
	listchars = 'tab:->,eol:¬,trail:-,extends:↩,precedes:↪', -- define characters for invisible characters
	mouse = "a", -- enable scrolling and selecting with mouse
	nu = true,
	rnu = true, -- show *HYBRID* line numbers, relative line numbers + current line number
	scrolloff = 2, -- always have 2 lines more visible when reaching top/end of a window when scrolling
	shell = "/bin/zsh", -- set default shell for :shell
	shiftround = true, -- When at 3 spaces and I hit >>, go to 4, not 5.
	shiftwidth = 2,
	showmatch = true, -- Highlight matching bracket
	signcolumn = "yes",
	smartcase = true, -- ignore 'ignorecase' when search contains uppercase characters
	softtabstop = 2,
	splitbelow = true, -- When on, splitting a window will put the new window below the current one
	synmaxcol = 500, -- Until which column vim parses syntax
	tabstop = 2,
	termguicolors = true, -- enable 24bit colors
	textwidth = 80,
	undofile = true,
	wrap = false, -- don't wrap text around when the window is too small
	wildignore = table.concat({
		".DS_Store",
		"**/.git/*",
		"*.jpg,*.bmp,*.gif,*.png,*.jpeg", -- ignore binary images
		"**/coverage/*",
		"**/node_modules/*",
		"**/android/*",
		"**/.git/*",
		"**/tmp/*",
	}, ","),
	wildmode="longest,list,full",
	runtimepath=vim.o.runtimepath .. ",~/personal/ghash-vim"
})

setWith(vim.g, {
	mapleader = " ",
	maplocalleader = "\\",

	UltiSnipsExpandTrigger="<c-l>",
	UltiSnipsJumpForwardTrigger="<c-l>",
	UltiSnipsJumpBackwardTrigger="<c-h>",

	netrw_altfile=1, -- make CTRL-^ ignore netrw buffers

	db_ui_force_echo_notifications=1,

	closetag_filenames = '*.html,*.xhtml,*.phtml,*.js,*.jsx,*.tsx',
	closetag_xhtml_filenames = '*.xhtml,*.jsx',
	closetag_filetypes = 'html,xhtml,phtml,jsx,tsx,javascript',
	closetag_xhtml_filetypes = 'xhtml,jsx,tsx',
	closetag_emptyTags_caseSensitive = 1,
	closetag_regions = {
		['typescript.tsx'] = 'jsxRegion,tsxRegion',
		['javascript.jsx'] = 'jsxRegion',
	},
	closetag_shortcut = '>',
	closetag_close_shortcut = '<leader>>',
})


-- TODO: convert to actual lua
vim.cmd([[
	" enable filtype plugins
	filetype plugin on

	" When saving a buffer, create directories if they do not yet exist.
	augroup Mkdir
		autocmd!
		autocmd BufWritePre * call mkdir(expand("<afile>:p:h"), "p")
	augroup END
]])

