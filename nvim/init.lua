--                                                               
--                 888        888    .d888d8b888                 
--                 888        888   d88P" Y8P888                 
--                 888        888   888      888                 
--             .d88888 .d88b. 888888888888888888 .d88b. .d8888b  
--            d88" 888d88""88b888   888   888888d8P  Y8b88K      
--            888  888888  888888   888   88888888888888"Y8888b. 
--            Y88b 888Y88..88PY88b. 888   888888Y8b.         X88 
--             "Y88888 "Y88P"  "Y888888   888888 "Y8888  88888P' 
--                                                               
                                                                 
-- make sure packer is installed {{{
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
  vim.cmd [[packadd packer.nvim]]
end
--}}}

require('packer').startup({ function(use)
  -- core utils {{{
  use('https://github.com/wbthomason/packer.nvim') -- packer can manage itself
  use('~/code/plenary.nvim') -- https://github.com/nvim-lua/plenary.nvim util functions. a dependency of many plugins
  use('https://github.com/dstein64/vim-startuptime') -- find the startup bottleneck
  use('https://github.com/kkharji/sqlite.lua') -- sqlite client in lua that some plugins use
  -- }}}
  -- general purpose tools {{{
  use('https://github.com/numToStr/Comment.nvim') -- comments, with more smartness
  use('https://github.com/tpope/vim-abolish') -- working with words (drastic understatement)
  use('https://github.com/tpope/vim-repeat') -- makes `.` even more powerful by adding support for plugins
  use('https://github.com/mattn/emmet-vim') -- div.emmet>p.is{awesome}
  use('https://github.com/tpope/vim-scriptease') -- helper commands useful when writing vim scripts etc
  use('https://github.com/theprimeagen/refactoring.nvim') -- Treesitter powered refactorings
  use('https://github.com/ThePrimeagen/harpoon') -- navigating to important files and commands at ludicrous speed
  use('https://github.com/godlygeek/tabular') -- align text at character. More powerful than :!column

  -- use('https://github.com/tpope/vim-surround') -- quoting/parenthesizing made simple. Extends functionality of s
  use("https://github.com/kylechui/nvim-surround") -- replacement of vim-surround with some neat features like `dsf` powered by TreeSitter
  -- }}}
  -- telescope  {{{
  use('https://github.com/nvim-telescope/telescope.nvim') -- extensive picker plugin/framework
  use('https://github.com/nvim-telescope/telescope-symbols.nvim') -- emoji/symbol picker
  use({ 'https://github.com/nvim-telescope/telescope-fzf-native.nvim', run = 'make' })
  use('https://github.com/nvim-telescope/telescope-frecency.nvim')
  -- }}}
  -- lsp stuff {{{
  use('https://github.com/williamboman/nvim-lsp-installer')
  -- use('https://github.com/williamboman/mason.nvim') -- package manager
  use('https://github.com/neovim/nvim-lspconfig') --  easy configs for language servers
  use('https://github.com/jose-elias-alvarez/null-ls.nvim') -- use neovim as ls server to inject code-actions and mor via lua
  use('https://github.com/jose-elias-alvarez/nvim-lsp-ts-utils')
  use('https://github.com/folke/trouble.nvim') -- pretty list for LSP diagnostics
  use('https://github.com/ray-x/lsp_signature.nvim') -- show function signatures from LSP when typing
  use({
    "glepnir/lspsaga.nvim",
    branch = "main",
    config = function()
      local saga = require("lspsaga")

      saga.init_lsp_saga({
        -- your configuration
        finder_action_keys = {
          open = "o",
          vsplit = "s",
          split = "i",
          tabe = "t",
          quit = "<Esc>",
          scroll_down = "<C-d>",
          scroll_up = "<C-u>",
        },
      })
    end,
  })
  -- }}}
  -- treesitter {{{
  use('https://github.com/nvim-treesitter/nvim-treesitter') -- simple API for treesitter for configuration and interactions
  use('https://github.com/nvim-treesitter/playground') -- visual representation and query playground for the AST of TS
  use('https://github.com/nvim-treesitter/nvim-treesitter-textobjects') -- create additional textobjects via TreeSitter (eg `if` => `@function.inner`)
  -- }}}
  -- git things {{{
  use('https://github.com/tpope/vim-fugitive') -- a git wrapper in vim
  use('https://github.com/lewis6991/gitsigns.nvim') -- show diff markers in the gutter + gitlens
  -- }}}
  -- completers {{{
  use('https://github.com/windwp/nvim-autopairs') -- auto pairs in lua
  use('https://github.com/windwp/nvim-ts-autotag') -- use TreeSitter to close and rename tags
  use('https://github.com/hrsh7th/nvim-cmp') -- completion engine written in lua, extendable via plugins
  use('https://github.com/hrsh7th/cmp-nvim-lsp') -- lsp source
  use('https://github.com/hrsh7th/cmp-nvim-lua') -- neovim LUA Api source
  use('https://github.com/hrsh7th/cmp-path') -- path completions
  use('https://github.com/hrsh7th/cmp-cmdline') -- source for cmdline (:, /)
  use('https://github.com/hrsh7th/cmp-buffer') -- buffer source
  -- }}}
  -- snippets {{{
  use('https://github.com/L3MON4D3/LuaSnip') -- the first snippet plugin to beat UltiSnips for me?
  use('~/code/rucksack.nvim') -- custom neovim plugin for stashing and persisting code for later user
  -- }}}
  -- debugging {{{
  use('https://github.com/mfussenegger/nvim-dap') -- DAP client
  use('https://github.com/rcarriga/nvim-dap-ui') -- DAP UI
  use('https://github.com/leoluz/nvim-dap-go') -- DAP Adapter for Go
  -- }}}
  -- UI {{{
  use('https://github.com/folke/zen-mode.nvim') -- distraction free writing and some other nice things
  use('https://github.com/folke/twilight.nvim') -- highlight only portion of text
  use('https://github.com/rmagatti/goto-preview') -- open gotos in floating windows
  use('https://github.com/folke/which-key.nvim') -- show possible keys when nvim is waiting for a key press
  use('https://github.com/nvim-lualine/lualine.nvim') -- easy to configure and extend statusline (+tabline, +windowline)
  use('https://github.com/kyazdani42/nvim-web-devicons') -- bunch of icons for web development
  use('https://github.com/Maan2003/lsp_lines.nvim') -- better display for inline diagnostic errors
  use('https://github.com/j-hui/fidget.nvim') -- ui for nvm-lsp progress
  use('https://github.com/kyazdani42/nvim-tree.lua') -- filetree when when :Lex or vinegar is not enough
  -- use('https://github.com/simrat39/symbols-outline.nvim') -- treeview for symbols in current buf
  use('https://github.com/stevearc/aerial.nvim') -- alternative to symbols-outline.nvim
  use('https://github.com/folke/todo-comments.nvim') -- easy configurable todo search in comment with support for Trouble
  use('https://github.com/simnalamburt/vim-mundo') -- browser for vim's undo tree, for when git is not enough
  -- }}}
  -- themes {{{
  use('https://github.com/rktjmp/lush.nvim') -- for easily creating colorschemes via DSL
  use('https://github.com/folke/tokyonight.nvim')
  use('~/code/bloop.nvim') -- 
  use('~/code/nazgul-vim') -- minimal hard contrast theme
  use('~/code/ghash.nvim') -- dark retro theme all in red
  -- }}}
  -- beyond coding {{{
  use('https://github.com/renerocksai/telekasten.nvim') -- zettelkasten within vim, works great with Obsidian
  use('https://github.com/jbyuki/instant.nvim') -- collaborative editing in nvim
  use('https://github.com/rest-nvim/rest.nvim') -- REST client
  use('https://github.com/tpope/vim-eunuch') -- vim sugar for the unix shell commands that need it the most. Like :delete, :move, :chmod
  use('https://github.com/tpope/vim-vinegar') -- improved netrw for file browsing.
  use('https://github.com/mcchrish/nnn.vim') -- using nnn in a floating window (and open file in vim)
  use('https://github.com/metakirby5/codi.vim') -- repl/scratchpad
  -- }}}

  if is_bootstrap then
    require('packer').sync()
  end
end,
})

if is_bootstrap then
  print '=================================='
  print '    Plugins are being installed'
  print '    Wait until Packer completes,'
  print '       then restart nvim'
  print '=================================='
  return
end

-- global helper utils {{{
if pcall(require, 'plenary') then
  RELOAD = require('plenary.reload').reload_module

  ---@param name string
  ---replace any require call with R and will always parse the file
  --
  ---example:
  ---```lua
  ---   -- will reload snock.utils whenever this is called
  ---   local utils = R('snock.utils')
  ---````
  R = function(name)
    RELOAD(name)
    return require(name)
  end
end

---print whaever
---@param v any
---@return any
P = function(v)
  print(vim.inspect(v))
  return v
end


vim.o.backup = true -- enable backups}}}
-- global options {{{
vim.o.laststatus = 2
vim.o.backupskip = '/tmp/*,/private/tmp/*' -- Make Vim able to edit crontab files again.
vim.o.backupdir = '/tmp'
vim.o.breakindent = true -- wrapped lines appear indendet
vim.o.clipboard = 'unnamed'
vim.o.fillchars = 'eob:⸱'
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
  '**/coverage/*',
  '**/node_modules/*',
  '**/android/*',
  '**/.git/*',
  '**/tmp/*',
}, ',')
vim.o.path = vim.o.path .. ',**'
vim.g.colors_name = 'bloop_nvim'
vim.o.background = 'dark'
vim.o.guifont = 'JetBrains Mono:h16'

vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

vim.g.netrw_altfile = 1 -- make CTRL-^ ignore netrw buffers
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 33

vim.g.symbols_outline = {
  auto_close = true,
  auto_preview = false,
  show_quides = false
}

vim.o.guicursor = "n-v-c:block-Cursor/lCursor,i-ci-ve:ver25-Cursor2/lCursor2,r-cr:hor20,o:hor50"
local group = vim.api.nvim_create_augroup('snock', { clear = true })

vim.diagnostic.config({
  virtual_text = false,
  virtual_lines = false
})
--}}}
-- global auto commands {{{
-- open readme on vimenter when no filename was given {{{
vim.api.nvim_create_autocmd('VimEnter', {
  group = group,
  callback = function()
    if #vim.fn.argv() > 0 then return end -- was called with a filename (probably, idc)
    for _, ext in ipairs({ "", "md", "txt" }) do
      local filename = "readme." .. ext
      -- throws an error atm
      -- if vim.fn.filereadable(filename) == 1 then
      --   vim.defer_fn(function()
      --   vim.cmd("edit " .. filename)
      --   end)
      --   return nil
      -- end
    end
  end
}) -- }}}
vim.api.nvim_create_autocmd('BufAdd', { --{{{
  callback = function()
    -- lazy load lsp and git
    require("snock.lsp")
    require("snock.git")
    require("snock.completion")
  end,
  group = group,
}) --}}}
vim.api.nvim_create_autocmd('insertenter', { --{{{
  callback = function()
    if vim.o.nu then
      vim.o.rnu = false
    end
    vim.o.list = true
  end,
  group = group,
}) --}}}
vim.api.nvim_create_autocmd('TermOpen', { --{{{
  callback = function()
    vim.bo.filetype = "terminal"
    vim.keymap.set('n', '<C-c>', 'i<C-c>', { buffer = true })
  end,
  group = group
}) --}}}
vim.api.nvim_create_autocmd('insertleave', { --{{{
  callback = function()
    if vim.o.nu then
      vim.o.rnu = true
    end
    vim.o.list = false
  end,
  group = group,
}) --}}}
vim.api.nvim_create_autocmd('TextYankPost', { --{{{
  callback = function()
    vim.highlight.on_yank()
  end,
  group = group,
  pattern = '*',
}) --}}}
-- }}}

-- vim: fen fdm=marker fdl=0 nowrap nolinebreak
