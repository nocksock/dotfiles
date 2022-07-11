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

map('n', '<leader>hs', gitsigns.stage_hunk, hunk '[s]tage')
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
map('n', '<leader>sc', builtin.commands, { desc = '[S]earch [C]ommands' })
map('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
map('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
map('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
map('n', '<leader>s.', function()
  local path = "~/personal/dotfiles"
  builtin.find_files(themes.get_dropdown({
    search_dirs = { path },
    hidden = true,
    layout_strategy = "horizontal",
    layout_config = {
      width = function(_, max_columns, _)
        return math.min(max_columns, 120)
      end,
      height = function(_, _, max_lines)
        return math.min(max_lines, 15)
      end,
    },
    cwd = path -- setting this trims the path
  }))
end, { desc = '[S]earch [.]dotfiles' })
map('n', '<leader>gb', ':Telescope git_branches theme=dropdown<cr>')
map('n', '<leader>/', builtin.current_buffer_fuzzy_find, { desc = '[/] Fuzzily search in current buffer' })

-- buffers
map('n', '<leader>bd', ':b#|bd#<cr>', { desc = "[B]uffer [D]elete" }) -- delete buffer without messing up window layout
map('n', '<leader>bp', ':bp<cr>', { desc = "[B]uffer [P]revious" })
map('n', '<leader>bf', ':bf<cr>', { desc = "[B]uffer [F]irst" })
map('n', '<leader>bl', ':bl<cr>', { desc = "[B]uffer [L]ast" })
map('n', '<leader>bO', ':%bd|e#<cr>', { desc = "[B]uffer [O]nly" })

-- files and folders
map('n', '<leader>cdc', ':cd %:h<CR>', { desc = "[C]hange [D]irectory to [c]urrent file's folder" })
map('n', '<leader>cdp', ':cd -<CR>', { desc = "[C]hange [D]irectory to [P]revious folder" })
map('n', '<leader>sne', ':lua require("luasnip.loaders.from_lua").edit_snippet_files()<CR>', { desc = "[Sn]ippet [E]dit" })
map('n', '<leader>sns', ':source ~/.config/nvim/plugin/luasnip.lua<cr>', { desc = "[Sn]ippet [S]ource" })

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
map('n', '_', ':NnnPicker<cr>')

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
local telekasten = require('telekasten')
map('n', '<leader>zf', telekasten.find_notes)
map('n', '<leader>zd', telekasten.find_daily_notes)
map('n', '<leader>zg', telekasten.search_notes)
map('n', '<leader>zz', telekasten.follow_link)
map('n', '<leader>zt', telekasten.goto_today)
map('n', '<leader>zW', telekasten.goto_thisweek)
map('n', '<leader>zw', telekasten.find_weekly_notes)
map('n', '<leader>zn', telekasten.new_note)
map('n', '<leader>zN', telekasten.new_templated_note)

-- muscle memory
map('n', '<leader>cp', ':LspFormatting<cr>')
map('n', '<leader>.', ':LspCodeAction<cr>')
map('n', '<F2>', ':LspRename<cr>')
map('n', '<c-l>', ':<c-u>:nohlsearch<cr>:pclose<cr><c-l>')

map('n', '<F12>', ':ToggleTerm<CR>')
map('v', '<F12>', ':ToggleTermSendVisualSelection<CR>')
map('t', '<F12>', [[<C-\><C-n>:ToggleTerm<CR>]])

-- misc convenience
-- when moving more than 5 lines, then make a jump, to be able to revert via c-o
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

-- misc: move text around (not: insert variations defined in luasnip mappings)
map('v', '<C-k>', ":m '<-2<CR>gv=gv")
map('v', '<C-j>', ":m '>+1<CR>gv=gv")

vim.cmd([[cnoremap <expr> %%  getcmdtype() == ':' ? expand('%:h').'/' : '%%']]) -- type %% in vim's prompt to insert %:h expanded
