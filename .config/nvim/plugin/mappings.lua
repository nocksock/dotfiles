local function map(mode, key, command, opts)
	opts = vim.tbl_extend('force', { noremap = true, silent = true }, opts or {})
	vim.api.nvim_set_keymap(mode, key, command, opts)
end

map('n', ']t', ':tabnext<cr>')
map('n', '[T', ':tabfirst<cr>')
map('n', ']T', ':tablast<cr>')
map('n', ']c', "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", { expr = true })
map('n', '[c', "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", { expr = true })
map('n', '[b', ':bprevious<cr>')
map('n', ']b', ':bnext<cr>')
map('n', '[B', ':bfirst<cr>')
map('n', ']B', ':blast<cr>')
map('n', '[d', ':LspDiagPrev<cr>')
map('n', ']d', ':LspDiagNext<cr>')
map('n', 'gx', ":execute '!open ' . shellescape(expand('<cWORD>'), 1)<cr>")
map('n', '<c-s>', ':w<cr>')
map('n', '<F3>', ':LspRename<cr>')
map('n', 'gV', '`[v`]') -- visual select last inserted text)
map('n', '_', ':NnnPicker<cr>')
map(
	'n',
	'<leader><leader>',
	':Telescope find_files template=dropdown find_command=rg,--hidden,--files<cr>'
)
map('n', '<leader>dts', [[mz:%s/ \+$//<cr>`z<cr>]]) -- delete trailing spaces
map('n', '<leader>es', ':UltiSnipsEdit<cr>')
map('n', '<leader>ki', '<Plug>:LspDiagLine<cr>')
map('n', '<leader>td', ':DBUIToggle<cr>')
map('n', '<leader>/', ':Telescope live_grep theme=ivy hidden=true<cr>')
map('n', '<leader>gg', ':tab G<cr>')
map('n', '<leader>gc', ':Git commit<cr>')
map(
	'n',
	'<leader>R',
	'<Esc><cmd>lua require("telescope").extensions.refactoring.refactors()<CR>'
)
map('n', '<leader>T', ':Telescope<CR>')
map('n', '<leader>b', ':Telescope buffers theme=ivy<cr>')
map('n', '<leader>l', ':Telescope current_buffer_fuzzy_find<cr>')
map('n', '<leader>r', ':Telescope oldfiles theme=dropdown<cr>')
map('n', '<leader>ih', ':Telescope help_tags theme=ivy<cr>')
map('n', '<leader>ik', ':Telescope keymaps theme=ivy<cr>')
map(
	'n',
	'<leader>fc',
	[[:lua require'telescope.builtin'.find_files({find_command='rg,--files,-g *.tsx'}) <CR>]]
)
map('n', '<leader>it', ':TSHighlightCapturesUnderCursor<cr>')
map('n', '<leader>io', ':Telescope lsp_document_symbols<cr>')
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
map('n', '<leader>M', '<cmd>Messages<CR>')
map('n', '<leader>m', '<cmd>messages<CR>')
-- theme toggle
map('n', '<leader>ttb', ':set background=dark|colors bloop<cr>')
map('n', '<leader>ttg', ':set background=dark|colors ghash<cr>')
map('n', '<leader>ttp', ':set background=light|colors PaperColor<cr>')
map('n', '<leader>tts', ':set background=dark|colors sunbather<cr>')
map('n', '<leader>ttt', ':Telescope colorscheme enable_preview=true<cr>')

-- toggles
map('n', '<leader>tz', ':ZenMode<cr>')
map('n', '<leader>tw', ':Twilight<cr>')

-- notes
map('n', '<leader>X', '<cmd>ped ~/notes/x.md<cr>')
map('n', '<leader>x', '<cmd>ped .notes.md<cr>')

-- muscle memory
map('n', '<leader>cp', ':LspFormatting<cr>')
map('n', '<leader>.', ':Telescope lsp_code_actions theme=cursor<cr>')

map('n', '<c-l>', ':<c-u>:nohlsearch<cr>:pclose<cr><c-l>', { silent = true })

map('n', '<F12>', ':FloatermToggle<CR>', { silent = true })
map('t', '<F12>', [["<C-\><C-n>:FloatermToggle<CR>"]], { silent = true })

map(
	'v',
	'<leader>R',
	'<Esc><cmd>lua require("telescope").extensions.refactoring.refactors()<CR>',
	{ silent = true }
)

map('i', 'jk', '<esc>', { silent = true })
map('i', ';;', '<Esc>m`A;<esc>``li') -- Easy insertion of a trailing ; from insert mode {silent = true})
map('i', ',,', '<Esc>m`A,<esc>``li') -- Easy insertion of a trailing , from insert mode {silent = true})

-- Text object
map('o', 'ih', ':<C-U>Gitsigns select_hunk<CR>')
map('x', 'ih', ':<C-U>Gitsigns select_hunk<CR>')
