local function map(mode, key, command, opts)
  opts = vim.tbl_extend('force', { noremap = true, silent = true }, opts or {})
  vim.keymap.set(mode, key, command, opts)
end

local gitsigns = require('gitsigns.actions')

map('n', '<leader>gg', ':tab G<cr>')
map('n', ']h', "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", { expr = true })
map('n', '[h', "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", { expr = true })

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

map('n', 'gpd', require('goto-preview').goto_preview_definition)
map('n', 'gpi', require('goto-preview').goto_preview_implementation)
map('n', 'gP', require('goto-preview').close_all_win)
map('n', 'gpr', require('goto-preview').goto_preview_references)
map('n', 'gR', '<cmd>Trouble lsp_references<cr>')

-- Telescope
local function search_in(path, search_fn)
  return function()
    local options = { hidden = true }

    if path ~= nil then
      local xpath = vim.fn.expand(path)
      options = vim.tbl_extend("force", options, {
        search_dirs = { xpath },
        cwd = xpath, -- setting this trims the path
      })
    end

    require('telescope.builtin')[vim.F.if_nil(search_fn, "find_files")](options)
  end
end

map('n', '<leader><cr>', ":lua require('telescope.builtin').resume()<cr>")
map('n', '<leader>R', ":lua require('telescope.extensions').refactoring.refactors()<cr>")
map('n', '<leader>tt', ":lua require('telescope.builtin').colorscheme({ enable_preview = true })<cr>")
map('n', '<leader>T', ":lua require('telescope.builtin').builtin()<cr>", { desc = 'builtin [T]elescope commands' })
map('n', '<leader><space>', ":lua require('telescope.builtin').buffers()<cr>", { desc = '[ ] Find existing buffers' })
map('n', '<leader>sf', search_in(nil), { desc = '[S]earch [F]iles' })
map('n', '<leader>s.', search_in("%:p:h"), { desc = '[S]earch files in current directory ([.]/)' })
map('n', '<leader>sdf', search_in(vim.fn.getenv('DOTDIR')), { desc = '[S]earch [d]ot[f]iles' })
map('n', '<leader>sr', ":lua require('telescope.builtin').oldfiles()<cr>", { desc = '[S]earch [R]ecently opened files' })
map('n', '<leader>sh', ":lua require('telescope.builtin').help_tags()<cr>", { desc = '[S]earch [H]elp' })
map('n', '<leader>sk', ":lua require('telescope.builtin').keymaps()<cr>", { desc = '[S]earch [K]eymaps' })
map('n', '<leader>sl', ":lua require('telescope.builtin').loclist()<cr>", { desc = '[S]earch [L]oclist' })
map('n', '<leader>sP',
  search_in('/Users/nilsriedemann/.local/share/nvim/site/pack/packer/start/plenary.nvim/', "grep_string"))
map('n', '<leader>sc', ":lua require('telescope.builtin').commands()<cr>", { desc = '[S]earch [C]ommands' })
map('n', '<leader>sw', ":lua require('telescope.builtin').grep_string()<cr>", { desc = '[S]earch current [W]ord' })
map('n', '<leader>sg', ":lua require('telescope.builtin').live_grep()<cr>", { desc = '[S]earch by [G]rep' })
map('n', '<leader>gb', ':Telescope git_branches theme=dropdown<cr>')
map('n', '<leader>/', ':lua require("telescope.builtin").current_buffer_fuzzy_find()<cr>',
  { desc = '[/] Fuzzily search in current buffer' })
map('n', '<leader>sp', search_in("~/.local/share/nvim/site/pack/packer/start/"),
  { desc = '[s]earch [P]lugins in packer folder' })
map('n', '<leader>sdb', ":lua require('telescope.builtin').diagnostics({ bufnr = 0 })<cr>",
  { desc = '[S]earch [d]iagnostics current [b]uffer' })
map('n', '<leader>sdw', ":lua require('telescope.builtin').diagnostics()<cr>",
  { desc = '[S]earch [d]iagnostics [w]orkspace' })

-- buffers
map('n', '<leader>bd', ':b#|bd#<cr>', { desc = "[B]uffer [D]elete" }) -- delete buffer without messing up window layout
map('n', '<leader>bO', ':%bd|e#<cr>', { desc = "[B]uffer [O]nly" })

-- infos
map('n', '<leader>it', ':TSHighlightCapturesUnderCursor<cr>')
map('n', '<leader>id', '<Plug>:LspDiagLine<cr>')

-- toggles
map('n', '<leader>te', ':NnnExplorer<cr>')
map('n', '<leader>tE', ':NnnExplorer %:p:h<cr>')
map('n', '_', ':NnnPicker %:p:h<cr>')

-- harpoon: nav_file
map('n', "<leader>'", ':lua require("harpoon.mark").add_file()<CR>')
map('n', "''", ':lua require("harpoon.ui").toggle_quick_menu()<CR>')
map('n', "'1", ':lua require("harpoon.ui").nav_file(1)<CR>')
map('n', "'2", ':lua require("harpoon.ui").nav_file(2)<CR>')
map('n', "'3", ':lua require("harpoon.ui").nav_file(3)<CR>')
map('n', "'4", ':lua require("harpoon.ui").nav_file(4)<CR>')
map('n', "'f", ':lua require("harpoon.ui").nav_file(1)<CR>')
map('n', "'d", ':lua require("harpoon.ui").nav_file(2)<CR>')
map('n', "'s", ':lua require("harpoon.ui").nav_file(3)<CR>')
map('n', "'a", ':lua require("harpoon.ui").nav_file(4)<CR>')

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

map('n', '<F12>', ':ToggleTerm<CR>')
map('v', '<F12>', ':ToggleTermSendVisualSelection<CR>')
map('t', '<F12>', [[<C-\><C-n>:ToggleTerm<CR>]])

-- misc convenience
map('n', '<leader>sns', ':source ~/.config/nvim/plugin/completion.lua<cr>', { desc = "[Sn]ippet [S]ource" })
map('n', 'j', [[(v:count > 5 ? "m'" . v:count : "") . 'gj']], { expr = true }) -- when moving more than 5 lines, then make a jump, to be able to revert via c-o
map('n', 'k', [[(v:count > 5 ? "m'" . v:count : "") . 'gk']], { expr = true })
map('n', 'gx', ":execute '!open ' . shellescape(expand('<cWORD>'), 1)<cr>")
map('n', 'gV', '`[v`]') -- visual select last inserted text)
map('n', '<leader>dts', [[mz:%s/ \+$//<cr>`z<cr>]]) -- delete trailing spaces
map('n', '<leader>cp', ':LspFormatting<cr>')
map('n', '<leader>.', ':LspCodeAction<cr>')
map('n', '<leader>cl', ':<c-u>:nohlsearch<cr>:pclose<cr><c-l>', { desc = "[CL]ear Display" })
map('n', '<leader>tl', ':lua require("lsp_lines").toggle()<cr>', { desc = "[T]oggle [L]sp lines" })

map('n', '<c-j>', '<c-w>j')
map('n', '<c-k>', '<c-w>k')
map('n', '<c-l>', '<c-w>l')
map('n', '<c-h>', '<c-w>h')
map('n', '<c-n>', 'gt')
map('n', '<c-p>', 'gT')
map('n', '<M-j>', ']d')
map('n', '<M-k>', '[d')

-- better terminal exits
map('t', '<c-[>', '<C-\\><C-n>')
map('t', '<Esc>', '<C-\\><C-n>')

-- misc: more undo stops in insert mode
map('i', '!', '!<c-g>u')
map('i', '.', '.<c-g>u')
map('i', ':', ':<c-g>u')
map('i', ';', ';<c-g>u')
map('i', '?', '?<c-g>u')
map('i', ',', ',<c-g>u')

-- misc: move text around
map('v', '<C-k>', ":m '<-2<CR>gv=gv")
map('v', '<C-j>', ":m '>+1<CR>gv=gv")

-- type %% in vim's prompt to insert %:h expanded
vim.cmd([[cnoremap <expr> %%  getcmdtype() == ':' ? expand('%:h').'/' : '%%']])
map({ 'i', 'n' }, '<M-s>', '<cmd>:w<cr>')
