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
	autoindent = true, -- Copy indent from current line when creating a new line                            --
	autoread = true, -- auto re-read file when it changed outside of vim, but not inside
	backup = true, -- enable backups
	breakindent = true, -- wrapped lines appear indendet
	expandtab = true, -- use spaces for indentation by default
	foldenable = true,
	gdefault = true, -- add g flag by default for :substitutions
	hidden = true, -- enable hidden buffers - so i can switch buffers even if current is changed.
	hlsearch = true, -- highlight search results
	incsearch = true, -- enable incremental search that would make vim jump around while typing
	ignorecase = true, -- ignore case by default - unless using uppercase/lowercase via smartcase
	list = true, -- Show invisible characters
	cursorline = true, -- Highlight the line of in which the cursor is present (or not)
	wrap = false, -- don't wrap text around when the window is too small
	nu = true,
	rnu = true, -- show *HYBRID* line numbers, relative line numbers + current line number
	shiftround = true, -- When at 3 spaces and I hit >>, go to 4, not 5.
	showcmd = true, -- display incomplete commands
	showmatch = true, -- Highlight matching bracket
	smartcase = true, -- ignore 'ignorecase' when search contains uppercase characters
	splitbelow = true, -- When on, splitting a window will put the new window below the current one
	termguicolors = true, -- enable 24bit colors
	undofile = true,
	wildmenu = true,
	backspace = "indent,eol,start", -- allow backspacing over everything in insert mode
	backupdir = "~/.config/nvim/tmp/backup/", -- backups
	backupskip = "/tmp/*,/private/tmp/*", -- Make Vim able to edit crontab files again.
	clipboard = "unnamed",
	completeopt = "menu,menuone,noselect",
	encoding = "utf-8",
	formatoptions = "qrn1j", -- format options when writing, joining lines or `gq` see  :he fo-table for meanings
	signcolumn = "yes",
	history = 10000, -- keep way more commands in history
	listchars = 'tab:->,eol:¬,trail:-,extends:↩,precedes:↪', -- define characters for invisible characters
	mouse = "a", -- enable scrolling and selecting with mouse
	scrolloff = 2, -- always have 2 lines more visible when reaching top/end of a window when scrolling
	shell = "/bin/zsh", -- set default shell for :shell
	shiftwidth = 2,
	softtabstop = 2,
	synmaxcol = 500, -- Until which column vim parses syntax
	tabstop = 2,
	textwidth = 80,
	undodir = "~/.config/nvim/tmp/undo/",
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

