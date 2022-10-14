vim.g.mapleader = ' '
vim.g.maplocalleader = ','

vim.g.colors_name = 'bloop'

vim.o.guicursor = "n-v-c:block-Cursor/lCursor,i-ci-ve:ver25-Cursor2/lCursor2,r-cr:hor20,o:hor50"

vim.g.symbols_outline = {
  auto_close = true,
  auto_preview = false,
  show_quides = false
}

vim.g.netrw_altfile = 1 -- make CTRL-^ ignore netrw buffers
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 33

vim.o.laststatus = 2
vim.o.backupskip = '/tmp/*,/private/tmp/*' -- Make Vim able to edit crontab files again.
vim.o.backup = true -- enable backups
vim.o.backupdir = '/tmp'
vim.o.breakindent = true -- wrapped lines appear indendet
vim.o.clipboard = 'unnamed'
vim.o.fillchars = 'eob:⸱'
vim.o.cmdheight = 1 -- hide command line (testing)
vim.o.showtabline = 1
vim.o.hidden = true -- makes it possible to leave a buffer if it has unsaved changes. `gd` etc fail horribly in those cases.
vim.o.completeopt = 'menu,menuone,noselect,longest,preview'
vim.o.expandtab = true
vim.o.cursorline = false -- Highlight the line of in which the cursor is present (or not)
vim.o.foldenable = false -- open all folds by default
vim.o.foldmethod = "marker"
vim.o.formatoptions = 'qrn1j' -- format options when writing, joining lines or `gq` see  :he fo-table for meanings
vim.o.gdefault = true -- add g flag by default for :substitutions
vim.o.ignorecase = true -- ignore case by default - unless using uppercase/lowercase via smartcase
vim.o.smartcase = true -- ignore 'ignorecase' when search contains uppercase characters
vim.o.list = false -- do not show invisible characters (there's an auto-command to show only in insert mode)
vim.o.listchars = 'tab:->,eol:¬,trail:-,extends:↩,precedes:↪,leadmultispace:···|,' -- define characters for invisible characters
vim.o.mouse = 'a' -- enable scrolling and selecting with mouse
vim.o.rnu = true -- show *HYBRID* line numbers, relative line numbers + current line number
vim.o.nu = true
vim.o.pumheight = 12 -- limit popupmenu to 10 lines
vim.o.scrolloff = 2 -- always have 2 lines more visible when reaching top/end of a window when scrolling
vim.o.shell = '/bin/zsh' -- set default shell for :shell
vim.o.shiftround = true -- When at 3 spaces and I hit >>, go to 4, not 5.
vim.o.updatetime = 250
vim.o.equalalways = false -- prevent resizing after window close
vim.o.shiftwidth = 2
vim.o.showmatch = true -- Highlight matching bracket
vim.o.showmode = false -- don't show the current mode - lualine handles this
vim.o.signcolumn = 'yes' -- always show signcolumn - prevents horizontal jumping
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
  '**/coverage/*' })
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
vim.o.background = 'dark'
vim.o.guifont = 'JetBrains Mono:h16'

vim.diagnostic.config({
  virtual_text = true,
})

vim.g.easy_align_delimiters = {
  -- align \, which I often use in bash scripts etc.
  [ [[\]] ]= {
    pattern=      [[\\]],
    left_margin=  1,
    right_margin= 0
  }
}
