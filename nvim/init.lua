-- ʕ •ᴥ•ʔ

-- bootstrap baggage.nvim
vim.g.baggage_path = vim.fn.stdpath("data") .. "/site/pack/baggage/"
if not (vim.uv or vim.loop).fs_stat(vim.g.baggage_path) then
  local out = vim.fn.system({ "git", "clone", "--depth=1", "--branch=main", "https://github.com/nocksock/baggage.nvim", vim.g.baggage_path .. 'start/baggage.nvim' })
  if vim.v.shell_error ~= 0 then
    vim.notify("Failed to clone baggage.nvim", vim.log.levels.ERROR)
  end
  vim.cmd("packloadall")
end

R = require "rr"
P = function(...)
  print(vim.inspect(...))
  return ...
end
TAP = P

-- general {{{
vim.g.mapleader      = ' '
vim.g.maplocalleader = ','
vim.o.clipboard      = 'unnamedplus'
vim.o.hidden         = true -- makes it possible to leave a buffer if it has unsaved changes. `gd` etc fail horribly in those cases.
vim.o.completeopt    = 'menu,menuone,noselect,longest,preview'
vim.o.foldmethod     = "marker"
vim.o.formatoptions  = 'qrn1j'    -- format options when writing, joining lines or `gq` see  :he fo-table for meanings
vim.o.mouse          = 'a'        -- enable scrolling and selecting with mouse
vim.o.updatetime     = 250
vim.o.splitbelow     = true       -- When on, splitting a window will put the new window below the current one
vim.o.shiftround     = true       -- When at 3 spaces and I hit >>, go to 4, not 5.
vim.o.shell          = '/bin/zsh' -- set default shell for :shell
vim.o.wildignore     = table.concat({
  '.DS_Store',
  '**/.git/*',
  '*.jpg,*.bmp,*.gif,*.png,*.jpeg', -- ignore binary images
  '**/coverage/*',
  '**/node_modules/*',
  '**/android/*',
  '**/.git/*',
  '**/tmp/*',
}, ',')

vim.o.jumpoptions    = 'stack' -- this makes much more sense for my brain

-- search settings
vim.o.gdefault       = true -- add g flag by default for :substitutions
vim.o.ignorecase     = true -- ignore case by default - unless using uppercase/lowercase via smartcase
vim.o.smartcase      = true -- ignore 'ignorecase' when search contains uppercase characters
vim.o.grepprg        = "rg --vimgrep"
vim.o.grepformat     = "%f:%l:%c:%m"

-- }}}
-- basic ui things {{{

vim.o.list           = false -- do not show invisible characters (there's an auto-command to show only in insert mode)
vim.o.listchars      =
'tab:->,eol:¬,trail:-,extends:↩,precedes:↪,leadmultispace:···|,' -- define characters for invisible characters
vim.cmd([[ set fillchars=eob:\  ]]) -- use a nicer vertical split character
vim.o.rnu                   = true
vim.o.nu                    = true
vim.o.cursorline            = false -- Highlight the line of in which the cursor is present (or not)
vim.o.showtabline           = 1
vim.o.scrolloff             = 2     -- always have 2 lines more visible when reaching top/end of a window when scrolling
vim.o.background            = "dark"
vim.o.showmatch             = true  -- Highlight matching bracket
vim.o.showmode              = false -- don't show the current mode - lualine handles this
vim.o.laststatus            = 2
vim.o.termguicolors         = true  -- enable 24bit colors
vim.o.guicursor             = "n-v-c:block-Cursor/lCursor,i-ci-ve:ver25-Cursor2/lCursor2,r-cr:hor20,o:hor50"
vim.o.cmdheight             = 1     -- height of the command bar

-- }}}
-- indentation and wrapping {{{

vim.o.shiftwidth            = 4
vim.o.softtabstop           = 4
vim.o.smartindent           = true
vim.o.textwidth             = 80
vim.o.expandtab             = true
vim.o.briopt                = 'shift:4' -- indent wrapped lines
vim.o.linebreak             = true
vim.o.wrap                  = false

-- }}}
-- backup + undo {{{

vim.o.swapfile              = false                   -- disable swap files
vim.o.backupskip            = '/tmp/*,/private/tmp/*' -- Make Vim able to edit crontab files again.
vim.o.backup                = true                    -- enable backups
vim.o.backupdir             = '/tmp'
vim.o.undofile              = true

-- }}}
-- plugin settings etc {{{

vim.g.netrw_altfile         = 1 -- make CTRL-^ ignore netrw buffers
vim.g.netrw_banner          = 0 -- hide banner
vim.g.netrw_winsize         = 33
vim.g.netrw_preview         = 1

vim.g.easy_align_delimiters = {
  -- align \, which I often use in bash scripts etc.
  [ [[\]] ] = {
    pattern = [[\\]],
    left_margin = 1,
    right_margin = 0
  }
}

-- }}}

vim.cmd([[
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val, "lnum": 1 }'))
  copen
  cc
endfunction
]])


