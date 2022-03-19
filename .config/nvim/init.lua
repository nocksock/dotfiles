-- welcome to my nvim config.
vim.o.backup = true -- enable backups
vim.o.backupskip = '/tmp/*,/private/tmp/*' -- Make Vim able to edit crontab files again.
vim.o.backupdir = '/tmp'
vim.o.breakindent = true -- wrapped lines appear indendet
vim.o.clipboard = 'unnamed'
vim.o.completeopt = 'menu,menuone,noselect,longest,preview'
vim.o.cursorline = true -- Highlight the line of in which the cursor is present (or not)
vim.o.expandtab = true -- use spaces for indentation by default
vim.o.foldenable = true
vim.o.formatoptions = 'qrn1j' -- format options when writing, joining lines or `gq` see  :he fo-table for meanings
vim.o.gdefault = true -- add g flag by default for :substitutions
vim.o.ignorecase = true -- ignore case by default - unless using uppercase/lowercase via smartcase
vim.o.list = true -- Show invisible characters
vim.o.listchars = 'tab:->,eol:¬,trail:-,extends:↩,precedes:↪' -- define characters for invisible characters
vim.o.mouse = 'a' -- enable scrolling and selecting with mouse
vim.o.nu = true
vim.o.rnu = true -- show *HYBRID* line numbers, relative line numbers + current line number
vim.o.pumheight=10 -- limit popupmenu to 10 lines
vim.o.scrolloff = 2 -- always have 2 lines more visible when reaching top/end of a window when scrolling
vim.o.shell = '/bin/zsh' -- set default shell for :shell
vim.o.shiftround = true -- When at 3 spaces and I hit >>, go to 4, not 5.
vim.o.shiftwidth = 2
vim.o.showmatch = true -- Highlight matching bracket
vim.o.signcolumn = 'yes'
vim.o.smartcase = true -- ignore 'ignorecase' when search contains uppercase characters
vim.o.softtabstop = 2
vim.o.splitbelow = true -- When on, splitting a window will put the new window below the current one
vim.o.synmaxcol = 500 -- Until which column vim parses syntax
vim.o.tabstop = 2
vim.o.termguicolors = true -- enable 24bit colors
vim.o.textwidth = 80
vim.o.undofile = true
vim.o.undodir = "/tmp"
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

vim.o.wildmode = 'longest,list,full'
vim.o.runtimepath = vim.o.runtimepath .. ',~/personal/ghash-vim'

vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

vim.g.UltiSnipsExpandTrigger = '<c-l>'
vim.g.UltiSnipsJumpForwardTrigger = '<c-l>'
vim.g.UltiSnipsJumpBackwardTrigger = '<c-h>'

vim.g.netrw_altfile = 1 -- make CTRL-^ ignore netrw buffers

vim.g.db_ui_force_echo_notifications = 1

vim.g.closetag_filenames = "*.html*.xhtml*.phtml*.js*.jsx*.tsx"
vim.g.closetag_xhtml_filenames = "*.xhtml*.jsx"
vim.g.closetag_filetypes = "html,xhtml,phtml,jsx,tsx,javascript"
vim.g.closetag_xhtml_filetypes = "xhtmljsxtsx"
vim.g.closetag_emptyTags_caseSensitive = 1
vim.g.closetag_regions = {
	['typescript.tsx'] = 'jsxRegion,tsxRegion',
	['javascript.jsx'] = 'jsxRegion',
}
vim.g.closetag_close_shortcut = '<leader>>'

vim.cmd([[
	filetype plugin on
	set background=dark
	colors sunbather

  augroup snock
    au!
    autocmd TermOpen * setlocal nonumber norelativenumber
    autocmd TermOpen * startinsert
    autocmd TermOpen * nnoremap <buffer> <C-c> i<C-c>
  augroup END!

	" When saving a buffer, create directories if they do not yet exist.
	augroup Mkdir
		autocmd!
		autocmd BufWritePre * call mkdir(expand("<afile>:p:h"), "p")
	augroup END
]])

P = function(v)
	print(vim.inspect(v))
	return v
end

if pcall(require, "plenary") then
	RELOAD = require("plenary.reload").reload_module

	R = function(name)
		RELOAD(name)
		return require(name)
	end
end
