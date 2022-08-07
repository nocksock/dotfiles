--
-- welcome to my nvim config.
--
require('packer').startup(function(use)
  use('https://github.com/wbthomason/packer.nvim') -- packer can manage itself
  use('https://github.com/nvim-lua/plenary.nvim') -- util functions. a dependency of many plugins
  use('https://github.com/dstein64/vim-startuptime') -- find the startup bottleneck
  use('https://github.com/mattn/emmet-vim') -- div.emmet>p.is{awesome}
  use('https://github.com/numToStr/Comment.nvim') -- comments, with more smartness
  use('https://github.com/tpope/vim-abolish') -- working with words (drastic understatement)
  use('https://github.com/tpope/vim-eunuch') -- vim sugar for the unix shell commands that need it the most. Like :delete, :move, :chmod
  use('https://github.com/tpope/vim-repeat') -- makes `.` even more powerful by adding support for plugins
  use('https://github.com/tpope/vim-surround') -- quoting/parenthesizing made simple. Extends functionality of s
  use('https://github.com/tpope/vim-vinegar') -- improved netrw for file browsing.

  -- telescope
  use('https://github.com/nvim-telescope/telescope.nvim') -- extensive picker plugin/framework
  use('https://github.com/nvim-telescope/telescope-symbols.nvim')
  use({ 'https://github.com/nvim-telescope/telescope-fzf-native.nvim', run = 'make' })

  -- lsp stuff
  use('https://github.com/williamboman/nvim-lsp-installer')
  use('https://github.com/neovim/nvim-lspconfig') --  easy configs for language servers
  use('https://github.com/jose-elias-alvarez/null-ls.nvim') -- use neovim as ls server to inject code-actions and mor via lua
  use('https://github.com/jose-elias-alvarez/nvim-lsp-ts-utils')
  use('https://github.com/folke/trouble.nvim') -- pretty list for LSP diagnostics

  -- treesitter
  use('https://github.com/nvim-treesitter/nvim-treesitter')
  use('https://github.com/nvim-treesitter/playground')
  use('vim-treesitter/nvim-treesitter-textobjects') --  Additional textobjects for treesitter

  -- git things
  use('https://github.com/tpope/vim-fugitive') -- a git wrapper in vim
  use('https://github.com/junegunn/gv.vim') -- commit browser
  use('https://github.com/lewis6991/gitsigns.nvim') -- show diff markers in the gutter + gitlens

  -- completers
  use('https://github.com/windwp/nvim-autopairs') -- auto pairs in lua
  use('https://github.com/windwp/nvim-ts-autotag') -- use TreeSitter to close and rename tags
  use('https://github.com/hrsh7th/nvim-cmp') -- smart completion
  use('https://github.com/hrsh7th/cmp-path')
  use('https://github.com/hrsh7th/cmp-buffer')
  use('https://github.com/hrsh7th/cmp-cmdline')
  use('https://github.com/hrsh7th/cmp-nvim-lua')
  use('https://github.com/hrsh7th/cmp-nvim-lsp')
  use('https://github.com/hrsh7th/cmp-nvim-lsp-signature-help')
  -- use('https://github.com/github/copilot.vim') -- let's give this a try

  -- snippets
  use('https://github.com/L3MON4D3/LuaSnip') -- the first snippet plugin to beat UltiSnips for me?
  use({ '~/personal/rucksack.nvim', requires = 'nvim-lua/plenary.nvim' }) -- custom neovim plugin for stashing and persisting code for later user

  -- helper
  use('https://github.com/tpope/vim-scriptease') -- helper commands useful when writing vim scripts etc
  use('https://github.com/theprimeagen/refactoring.nvim') -- Treesitter powered refactorings
  use('https://github.com/ThePrimeagen/harpoon') -- navigating to important files and commands at ludicrous speed

  use('https://github.com/simnalamburt/vim-mundo') -- browser for vim's undo tree, for when git is not enough
  use('https://github.com/godlygeek/tabular') -- align text at character. More powerful than :!column
  use('https://github.com/akinsho/toggleterm.nvim') -- quick access to builtin terminal
  use('https://github.com/mcchrish/nnn.vim') -- using nnn in a floating window (and open file in vim)

  -- ui
  use('https://github.com/folke/zen-mode.nvim') -- distraction free writing and some other nice things
  use('https://github.com/folke/twilight.nvim') -- highlight only portion of text
  use('https://github.com/rmagatti/goto-preview') -- open gotos in floating windows
  use('https://github.com/folke/which-key.nvim')
  use('https://github.com/nvim-lualine/lualine.nvim')
  use('https://github.com/kyazdani42/nvim-web-devicons')

  -- themes
  use('https://github.com/rktjmp/lush.nvim') -- for easily creating colorschemes via DSL
  use('https://github.com/nlknguyen/papercolor-theme') -- for moments I need a bright theme
  use('https://github.com/ayu-theme/ayu-vim')
  use('https://github.com/folke/tokyonight.nvim')
  use('~/personal/bloop-vim')
  use('~/personal/nazgul-vim')
  use('~/personal/ghash-nvim')

  -- beyond coding
  use('https://github.com/renerocksai/telekasten.nvim') -- zettelkasten within vim, works great with Obsidian
  use('https://github.com/jbyuki/instant.nvim') -- collaborative editing in nvim
end)


vim.o.backup = true -- enable backups
vim.o.laststatus = 3 -- global status line
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
vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.keymap.set("n", "<CR>", "za")
vim.o.formatoptions = 'qrn1j' -- format options when writing, joining lines or `gq` see  :he fo-table for meanings
vim.o.gdefault = true -- add g flag by default for :substitutions
vim.o.ignorecase = true -- ignore case by default - unless using uppercase/lowercase via smartcase
vim.o.list = true -- Show invisible characters
vim.o.listchars = 'tab:->,eol:¬,trail:-,extends:↩,precedes:↪' -- define characters for invisible characters
vim.o.mouse = 'a' -- enable scrolling and selecting with mouse
vim.o.nu = true -- show numbers
vim.o.rnu = true -- show *HYBRID* line numbers, relative line numbers + current line number
vim.o.pumheight = 12 -- limit popupmenu to 10 lines
vim.o.scrolloff = 2 -- always have 2 lines more visible when reaching top/end of a window when scrolling
vim.o.shell = '/bin/zsh' -- set default shell for :shell
vim.o.shiftround = true -- When at 3 spaces and I hit >>, go to 4, not 5.
vim.o.updatetime = 250
vim.o.shiftwidth = 2
vim.o.showmatch = true -- Highlight matching bracket
vim.o.showmode = false -- don't show the current mode - lualine handles this
vim.o.signcolumn = 'yes' -- always show signcolumn - prevents horizontal jumping
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

vim.g.instant_username = "nils"
vim.o.guicursor = "n-v-c:block-Cursor/lCursor,i-ci-ve:ver25-Cursor2/lCursor2,r-cr:hor20,o:hor50"
local group = vim.api.nvim_create_augroup('snock', { clear = true })

vim.api.nvim_create_autocmd({ 'BufReadPost', 'FileReadPost' }, {
  callback = function()
    vim.api.nvim_command([[normal zR]])
  end
})

vim.api.nvim_create_autocmd('TermOpen', {
  callback = function()
    vim.b.nu = false
    vim.b.rnu = false
    vim.b.startinsert = true
    vim.keymap.set('n', '<C-c>', 'i<C-c>', { buffer = true })
  end,
  group = group
})

vim.api.nvim_create_autocmd('insertenter', {
  callback = function()
    if vim.o.nu then
      vim.o.rnu = false
    end
    vim.o.list = true
  end,
  group = group,
})

vim.api.nvim_create_autocmd('insertleave', {
  callback = function()
    if vim.o.nu then
      vim.o.rnu = true
    end
    vim.o.list = false
  end,
  group = group,
})

local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

require('nvim-autopairs').setup({
  disable_filetype = { "TelescopePrompt", "fennel" }
});

require('comment').setup({})
require('harpoon').setup({ enter_on_sendcmd = true, })
require('gitsigns').setup({})
require('rucksack').setup({ mappings = true })
require('refactoring').setup({})
require('toggleterm').setup({})
require('goto-preview').setup({})
require('which-key').setup({ window = { border = 'single' } })
require('nvim-ts-autotag').setup({ update_on_insert = true })
