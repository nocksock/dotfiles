local function map(mode, key, command, opts)
  opts = vim.tbl_extend('force', { noremap = true, silent = true }, opts or {})
  vim.keymap.set(mode, key, command, opts)
end

local gitsigns = require('gitsigns.actions')

map('n', ']h', "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", { expr = true })
map('n', '[h', "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", { expr = true })
map('n', ']c', "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", { expr = true })
map('n', '[c', "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", { expr = true })
map('n', '[d', ':LspDiagPrev<cr>')
map('n', ']d', ':LspDiagNext<cr>')

map('n', '<leader>e', vim.diagnostic.open_float)
map('n', '<leader>q', vim.diagnostic.setloclist)

-- Git Actions
map('n', '<leader>gg', ':tab G<cr>')
map('n', '<leader>gc', ':Git commit<cr>')

local function hunk(suffix) return { desc = "[H]unk " .. suffix } end

map('n', '<localleader>hs', gitsigns.stage_hunk, hunk '[s]tage')
map('v', '<leader>hs', gitsigns.stage_hunk, hunk '[s]tage')
map('n', '<leader>hr', gitsigns.reset_hunk, hunk '[r]eset')
map('v', '<leader>hr', gitsigns.reset_hunk, hunk '[r]eset')
map('n', '<leader>hu', gitsigns.undo_stage_hunk, hunk '[U]ndo stage')
map('n', '<leader>hS', gitsigns.stage_buffer, hunk '[S]tage buffer')
map('n', '<leader>hR', gitsigns.reset_buffer, hunk '[R]eset buffer')
map('n', '<leader>hp', gitsigns.preview_hunk)
map('n', '<leader>hb', ':lua require"gitsigns".blame_line{full=true}<CR>')
map('n', '<leader>hd', gitsigns.diffthis)
map('n', '<leader>hD', ':lua require"gitsigns".diffthis("~")<CR>')

map('o', 'ih', gitsigns.select_hunk)
map('x', 'ih', gitsigns.select_hunk)

map('n', '<leader>tgb', gitsigns.toggle_current_line_blame, { desc = "[T]oggle inline [B]lame" })
map('n', '<leader>tgd', gitsigns.toggle_deleted, { desc = "[T]oggle [D]eleted lines" })
map('n', '<leader>tl', function()
  vim.o.nu = not vim.o.nu
  vim.o.rnu = not vim.o.rnu
end)
map('n', '<leader>tL', function()
  vim.o.nu = not vim.o.nu
  vim.o.rnu = not vim.o.rnu
  vim.o.signcolumn = vim.o.nu and "yes" or "no"
end)
map('n', '<leader>ts', function()
  if vim.o.laststatus == 2 then
    vim.o.laststatus = 0
  else
    vim.o.laststatus = 2
  end
end)

-- Text object
map('o', 'ih', ':<C-U>Gitsigns select_hunk<CR>')
map('x', 'ih', ':<C-U>Gitsigns select_hunk<CR>')

map('n', 'gpd', require('goto-preview').goto_preview_definition)
map('n', 'gpi', require('goto-preview').goto_preview_implementation)
map('n', 'gP', require('goto-preview').close_all_win)
map('n', 'gpr', require('goto-preview').goto_preview_references)
map('n', 'gR', '<cmd>Trouble lsp_references<cr>')

-- Telescope
local builtin = require 'telescope.builtin'
local extensions = require('telescope').extensions
local themes = require('telescope.themes')

local function find_files()
  builtin.find_files(themes.get_dropdown({
    hidden = true,
    layout_config = {
      width = function(_, max_columns, _)
        return math.min(max_columns, 120)
      end,
      height = function(_, _, max_lines)
        return math.min(max_lines, 20)
      end,
    },
  }))
end

map('n', '<leader><cr>', builtin.resume)
map('n', '<leader>R', extensions.refactoring.refactors)
map('n', '<leader>ttt', function()
  builtin.colorscheme { enable_preview = true }
end)
map('n', '<leader>T', builtin.builtin, { desc = 'builtin [T]elescope commands' })
map('n', '<leader><space>', builtin.buffers, { desc = '[ ] Find existing buffers' })
map('n', '<leader>sf', find_files, { desc = '[S]earch [F]iles' })
map('n', '<M-p>', find_files, { desc = '[S]earch [F]iles' })
map('n', '<leader>sr', builtin.oldfiles, { desc = '[S]earch [R]ecently opened files' })
map('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
map('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
map('n', '<leader>sl', builtin.loclist, { desc = '[S]earch [L]oclist' })
map('n', '<leader>sq', builtin.quickfix, { desc = '[S]earch [Q]uickfix' })
map('n', '<leader>sc', builtin.commands, { desc = '[S]earch [C]ommands' })
map('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
map('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
map('n', '<leader>sd', function() builtin.diagnostics({ bufnr = 0 }) end,
  { desc = '[S]earch [d]iagnostics current buffew' })
map('n', '<leader>sD', builtin.diagnostics, { desc = '[S]earch [D]iagnostics workspace' })
map('n', '<leader>s.', function()
  local path = vim.fn.getenv('DOTDIR')
  builtin.find_files(themes.get_dropdown({
    search_dirs = { path },
    cwd = path, -- setting this trims the path
    hidden = true,
  }))
end, { desc = '[S]earch [.]dotfiles' })
map('n', '<leader>gb', ':Telescope git_branches theme=dropdown<cr>')
map('n', '<leader>/', builtin.current_buffer_fuzzy_find, { desc = '[/] Fuzzily search in current buffer' })
map('n', '<leader>?', ":execute ':Telescope current_buffer_fuzzy_find' . expand('<cWORD>')<cr>")

-- buffers
map('n', '<leader>bd', ':b#|bd#<cr>', { desc = "[B]uffer [D]elete" }) -- delete buffer without messing up window layout
map('n', '<leader>bp', ':bp<cr>', { desc = "[B]uffer [P]revious" })
map('n', '<leader>bf', ':bf<cr>', { desc = "[B]uffer [F]irst" })
map('n', '<leader>bl', ':bl<cr>', { desc = "[B]uffer [L]ast" })
map('n', '<leader>bO', ':%bd|e#<cr>', { desc = "[B]uffer [O]nly" })

-- infos
map('n', '<leader>it', ':TSHighlightCapturesUnderCursor<cr>')
map('n', '<leader>id', '<Plug>:LspDiagLine<cr>')

-- theme toggle
map('n', '<leader>ttb', ':colors bloop<cr>')
map('n', '<leader>ttg', ':colors ghash<cr>')
map('n', '<leader>tty', ':colors tokyonight<cr>')
map('n', '<leader>ttp', ':colors PaperColor<cr>')
map('n', '<leader>ttn', ':colors nazgul<cr>')
map('n', '<leader>tbg', ':lua vim.o.background = vim.o.background == "dark" and "light" or "dark"<CR>')

-- toggles
map('n', '<leader>tnw', ':let g:netrw_chgwin=-1<CR>') -- TODO: find a better way to handle this
map('n', '<leader>tz', ':ZenMode<cr>')
map('n', '<leader>tw', ':Twilight<cr>')
map('n', '<leader>tcl', ':lua vim.o.cursorline = not vim.o.cursorline<CR>')
map('n', '<leader>tne', ':NnnExplorer<cr>')
map('n', '<leader>tnE', ':NnnExplorer %:p:h<cr>')
map('n', '_', ':NnnPicker %:p:h<cr>')

-- harpoon: nav_file
map('n', "<leader>'", ':lua require("harpoon.mark").add_file()<CR>')
map('n', "''", ':lua require("harpoon.ui").toggle_quick_menu()<CR>')
map('n', "'1", ':lua require("harpoon.ui").nav_file(1)<CR>')
map('n', "'2", ':lua require("harpoon.ui").nav_file(2)<CR>')
map('n', "'3", ':lua require("harpoon.ui").nav_file(3)<CR>')
map('n', "'4", ':lua require("harpoon.ui").nav_file(4)<CR>')

-- harpoon: cmd
map('n', '""', ':lua require("harpoon.cmd-ui").toggle_quick_menu()<CR>')
map('n', '"1', ':lua require("harpoon.term").gotoTerminal(1)<CR>')
map('n', '"2', ':lua require("harpoon.term").gotoTerminal(2)<CR>')
map('n', '"3', ':lua require("harpoon.term").gotoTerminal(3)<CR>')
map('n', '"4', ':lua require("harpoon.term").gotoTerminal(4)<CR>')

-- zettelkasten
local zettel = function(desc)
  return { desc = "[Z]ettel " .. desc }
end
map('n', '<leader>zf', ':lua require("telekasten").find_notes()<cr>', zettel('[F]ind notes'))
map('n', '<leader>zd', ':lua require("telekasten").find_daily_notes()<cr>', zettel('find [D]aily notes'))
map('n', '<leader>zg', ':lua require("telekasten").search_notes()<cr>', zettel('[g]rep notes'))
map('n', '<leader>zz', ':lua require("telekasten").follow_link()<cr>', zettel('[z] follow link'))
map('n', '<leader>zt', ':lua require("telekasten").goto_today()<cr>', zettel('goto [T]oday'))
map('n', '<leader>zW', ':lua require("telekasten").goto_thisweek()<cr>', zettel('goto this [W]eek'))
map('n', '<leader>zw', ':lua require("telekasten").find_weekly_notes()<cr>', zettel('find [w]eekly notes'))
map('n', '<leader>zn', ':lua require("telekasten").new_note()<cr>', zettel('[n]ew note'))
map('n', '<leader>zN', ':lua require("telekasten").new_templated_note()<cr>', zettel('[N]ew templated note'))

-- pocket.nvim
map('n', '<leader>p', ':lua require("rucksack").show()<cr>')
map('i', '<C-S-R>', '<esc>:lua require("rucksack").show({put = true})<CR>')
map('n', '<leader>y', ':lua require("rucksack").stash()<cr>')
map('v', '<leader>y', ':lua require("rucksack").stash()<cr>')

map('n', '<F12>', ':ToggleTerm<CR>')
map('v', '<F12>', ':ToggleTermSendVisualSelection<CR>')
map('t', '<F12>', [[<C-\><C-n>:ToggleTerm<CR>]])

-- misc convenience
-- when moving more than 5 lines, then make a jump, to be able to revert via c-o
map('n', '<leader>sne', ':lua require("luasnip.loaders.from_lua").edit_snippet_files()<CR>',
  { desc = "[Sn]ippet [E]dit" })
map('n', '<leader>sns', ':source ~/.config/nvim/plugin/luasnip.lua<cr>', { desc = "[Sn]ippet [S]ource" })
map('n', 'j', [[(v:count > 5 ? "m'" . v:count : "") . 'j']], { expr = true })
map('n', 'k', [[(v:count > 5 ? "m'" . v:count : "") . 'k']], { expr = true })
map('n', 'gx', ":execute '!open ' . shellescape(expand('<cWORD>'), 1)<cr>")
map('n', 'gV', '`[v`]') -- visual select last inserted text)
map('n', '<leader>dts', [[mz:%s/ \+$//<cr>`z<cr>]]) -- delete trailing spaces
map('n', '<leader>xx', '<cmd>TroubleToggle<cr>')

-- better terminal exits
map('t', '<c-[>', '<C-\\><C-n>')
map('t', '<Esc>', '<C-\\><C-n>')

-- misc: undo breaks in insert mode
map('i', '!', '!<c-g>u')
map('i', '.', '.<c-g>u')
map('i', ':', ':<c-g>u')
map('i', ';', ';<c-g>u')
map('i', '?', '?<c-g>u')
map('i', ',', ',<c-g>u')

-- misc: move text around
map('v', '<C-k>', ":m '<-2<CR>gv=gv")
map('v', '<C-j>', ":m '>+1<CR>gv=gv")

vim.cmd([[cnoremap <expr> %%  getcmdtype() == ':' ? expand('%:h').'/' : '%%']]) -- type %% in vim's prompt to insert %:h expanded

-- muscle memory
map('n', '<leader>cp', ':LspFormatting<cr>')
map('n', '<leader>.', ':LspCodeAction<cr>')
map('n', '<m-.>', ':LspCodeAction<cr>')
map('n', '<F2>', ':LspRename<cr>')
map({ 'i', 'n' }, '<M-s>', '<cmd>:w<cr>')
map('n', '<c-l>', ':<c-u>:nohlsearch<cr>:pclose<cr><c-l>')
