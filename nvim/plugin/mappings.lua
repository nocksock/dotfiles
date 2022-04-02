local function map(mode, key, command, opts)
	if command == nil then
		error("command is missing in ".. mode .." map with keys: " .. key)
	end
	opts = vim.tbl_extend('force', { noremap = true, silent = true }, opts or {})
	vim.api.nvim_set_keymap(mode, key, command, opts)
end

map('n', ']h', "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", { expr = true })
map('n', '[h', "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", { expr = true })
map('n', '[b', ':bprevious<cr>')
map('n', ']b', ':bnext<cr>')
map('n', '[B', ':bfirst<cr>')
map('n', ']B', ':blast<cr>')
map('n', ']c', "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", { expr = true })
map('n', '[c', "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", { expr = true })
map('n', '[d', ':LspDiagPrev<cr>')
map('n', ']d', ':LspDiagNext<cr>')

-- git
map('n', '<leader>gg', ':tab G<cr>')
map('n', '<leader>gc', ':Git commit<cr>')

-- Actions
map('n', '<leader>hs', ':Gitsigns stage_hunk<CR>')
map('v', '<leader>hs', ':Gitsigns stage_hunk<CR>')
map('n', '<leader>hr', ':Gitsigns reset_hunk<CR>')
map('v', '<leader>hr', ':Gitsigns reset_hunk<CR>')
map('n', '<leader>hS', '<cmd>Gitsigns stage_buffer<CR>')
map('n', '<leader>hu', '<cmd>Gitsigns undo_stage_hunk<CR>')
map('n', '<leader>hR', '<cmd>Gitsigns reset_buffer<CR>')
map('n', '<leader>hp', '<cmd>Gitsigns preview_hunk<CR>')
map('n', '<leader>hb', '<cmd>lua require"gitsigns".blame_line{full=true}<CR>')
map('n', '<leader>hd', '<cmd>Gitsigns diffthis<CR>')
map('n', '<leader>hD', '<cmd>lua require"gitsigns".diffthis("~")<CR>')

map('n', '<leader>tb', '<cmd>Gitsigns toggle_current_line_blame<CR>')
map('n', '<leader>td', '<cmd>Gitsigns toggle_deleted<CR>')

-- Text object
map('o', 'ih', ':<C-U>Gitsigns select_hunk<CR>')
map('x', 'ih', ':<C-U>Gitsigns select_hunk<CR>')

map('n', 'gpd', "<cmd>lua require('goto-preview').goto_preview_definition()<CR>")
map('n', 'gpi', "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>")
map('n', 'gP', "<cmd>lua require('goto-preview').close_all_win()<CR>")
map('n', 'gpr', "<cmd>lua require('goto-preview').goto_preview_references()<CR>")
map(
	'n',
	'<leader>R',
	'<Esc><cmd>lua require("telescope").extensions.refactoring.refactors()<CR>'
)
map('n', '<leader>T', ':Telescope<CR>')
map('n', '<leader>b', ':Telescope buffers theme=ivy<cr>')
map('n', '<leader>gb', ':Telescope buffers theme=dropdown<cr>')
map('n', '<leader>l', ':Telescope current_buffer_fuzzy_find<cr>')
map('n', '<leader>r', ':Telescope oldfiles theme=dropdown<cr>')
map('n', '<leader>xx', '<cmd>Trouble<cr>')
map('n', 'gR', '<cmd>Trouble lsp_references<cr>')

-- infos
map('n', '<leader>ih', ':Telescope help_tags theme=ivy<cr>')
map('n', '<leader>ik', ':Telescope keymaps theme=ivy<cr>')
map('n', '<leader>it', ':TSHighlightCapturesUnderCursor<cr>')
map('n', '<leader>io', ':Telescope lsp_document_symbols<cr>')

-- git
map('n', '<leader>hs', ':Gitsigns stage_hunk<CR>')
map('v', '<leader>hs', ':Gitsigns stage_hunk<CR>')
map('n', '<leader>hr', ':Gitsigns reset_hunk<CR>')
map('v', '<leader>hr', ':Gitsigns reset_hunk<CR>')
map('n', '<leader>hS', '<cmd>Gitsigns stage_buffer<CR>')
map('n', '<leader>hu', '<cmd>Gitsigns undo_stage_hunk<CR>')
map('n', '<leader>hR', '<cmd>Gitsigns reset_buffer<CR>')
map('n', '<leader>hp', '<cmd>Gitsigns preview_hunk<CR>')
map('n', '<leader>hb', '<cmd>lua require"gitsigns".blame_line{full=true}<CR>')
map('n', '<leader>hd', '<cmd>Gitsigns diffthis<CR>')
map('n', '<leader>hD', '<cmd>lua require"gitsigns".diffthis("~")<CR>')
map('n', '<leader>tb', '<cmd>Gitsigns toggle_current_line_blame<CR>')
map('n', '<leader>td', '<cmd>Gitsigns toggle_deleted<CR>')

-- Text object
map('o', 'ih', ':<C-U>Gitsigns select_hunk<CR>')
map('x', 'ih', ':<C-U>Gitsigns select_hunk<CR>')

-- theme toggle
map('n', '<leader>ttb', ':colors bloop<cr>')
map('n', '<leader>ttg', ':colors ghash<cr>')
map('n', '<leader>ttp', ':colors PaperColor<cr>')
map('n', '<leader>tts', ':colors sunbather<cr>')
map('n', '<leader>ttn', ':colors nazgul<cr>')
map('n', '<leader>ttt', ':Telescope colorscheme enable_preview=true<cr>')

-- toggles
map('n', '<leader>tz', ':ZenMode<cr>')
map('n', '<leader>tw', ':Twilight<cr>')
map('n', '<leader>tcl', ':lua vim.o.cursorline = not vim.o.cursorline<CR>')
map('n', '<leader>tbg', ':lua vim.o.background = vim.o.background == "dark" and "light" or "dark"<CR>')

-- harpoon: nav_file
map('n', "<leader>'", ':lua require("harpoon.mark").add_file()<CR>')
map('n', "''", ':lua require("harpoon.ui").toggle_quick_menu()<CR>')
map('n', "'a", ':lua require("harpoon.ui").nav_file(1)<CR>')
map('n', "'s", ':lua require("harpoon.ui").nav_file(2)<CR>')
map('n', "'d", ':lua require("harpoon.ui").nav_file(3)<CR>')
map('n', "'f", ':lua require("harpoon.ui").nav_file(4)<CR>')

-- harpoon: cmd
map('n', '""', ':lua require("harpoon.cmd-ui").toggle_quick_menu()<CR>')
map('n', '"a', ':lua require("harpoon.term").gotoTerminal(1)<CR>')
map('n', '"s', ':lua require("harpoon.term").gotoTerminal(2)<CR>')
map('n', '"d', ':lua require("harpoon.term").gotoTerminal(3)<CR>')
map('n', '"f', ':lua require("harpoon.term").gotoTerminal(4)<CR>')

-- notes
map('n', '<leader>X', '<cmd>ped ~/notes/x.md<cr>')
map('n', '<leader>x', '<cmd>ped .notes.md<cr>')

-- muscle memory
map('n', '<leader>cp', ':LspFormatting<cr>')
map('n', '<leader>.', ':Telescope lsp_code_actions theme=cursor<cr>')
map('n', '<F3>', ':LspRename<cr>')
map('n', '<c-l>', ':<c-u>:nohlsearch<cr>:pclose<cr><c-l>')

map('n', '<F12>', ':ToggleTerm<CR>')
map('v', '<F12>', ':ToggleTermSendVisualSelection<CR>')
map('t', '<F12>', [["<C-\><C-n>:ToggleTerm<CR>"]])

-- misc convenience
map('n', 'j', [[(v:count > 5 ? "m'" . v:count : "") . 'j']], { expr = true })
map('n', 'k', [[(v:count > 5 ? "m'" . v:count : "") . 'k']], { expr = true })
map('n', 'gx', ":execute '!open ' . shellescape(expand('<cWORD>'), 1)<cr>")
map('n', '<c-s>', ':w<cr>')
map('n', 'gV', '`[v`]') -- visual select last inserted text)
map('n', '_', ':NnnPicker<cr>')
map(
	'n',
	'<leader><leader>',
	':Telescope find_files template=dropdown find_command=rg,--hidden,--files<cr>'
)
map('n', '<c-space>', ':Telescope resume<cr>')
map('n', '<leader>dts', [[mz:%s/ \+$//<cr>`z<cr>]]) -- delete trailing spaces
map('n', '<leader>ki', '<Plug>:LspDiagLine<cr>')
map('n', '<leader>db', ':DBUIToggle<cr>')
map('n', '<leader>/', ':Telescope live_grep theme=ivy hidden=true<cr>')
map('t', '<c-[>', '<C-\\><C-n>')
map('t', '<Esc>', '<C-\\><C-n>')
map('v', '<leader>R', ':lua require("telescope").extensions.refactoring.refactors()<CR>')
map('i', '<M-CR>', '<esc>o')

-- misc: undo breaks in insert mode
map('i', '!', '!<c-g>u')
map('i', '.', '.<c-g>u')
map('i', '?', '?<c-g>u')
map('i', ',', ',<c-g>u')

-- misc: move text around
map('n', '<C-k>', ':m .-2<CR>==')
map('v', '<C-j>', ":m '>+1<CR>gv=gv")
map('v', '<C-k>', ":m '<-2<CR>gv=gv")

-- snippets
map('n', '<leader>sl', '<cmd>source ~/.config/nvim/plugin/luasnip.lua<CR>')

