local noremap = require('mapper').noremap

noremap.n({
	['[t'] = ':tabprevious<cr>',
	[']t'] = ':tabnext<cr>',
	['[T'] = ':tabfirst<cr>',
	[']T'] = ':tablast<cr>',
	['[b'] = ':bprevious<cr>',
	[']b'] = ':bnext<cr>',
	['[B'] = ':bfirst<cr>',
	[']B'] = ':blast<cr>',
	['[d'] = ':LspDiagPrev<cr>',
	[']d'] = ':LspDiagNext<cr>',
	['gx'] = ":execute '!open ' . shellescape(expand('<cWORD>'), 1)<cr>",
	['<c-s>'] = ':w<cr>',
	['<F2>'] = ':LspRename<cr>',
	['gV'] = '`[v`]', -- visual select last inserted text
	['_'] = ':NnnPicker<cr>',
	['<leader><leader>'] = ':Telescope find_files find_command=rg,--hidden,--files<cr>', -- TODO: move options to upper call signature (and merge with lower)
	['<leader>dts'] = [[mz:%s/ \+$//<cr>`z<cr>]],
	['<leader>es'] = ':UltiSnipsEdit<cr>',
	['<leader>ki'] = '<Plug>:LspDiagLine<cr>',
	['<leader>td'] = ':DBUIToggle<cr>',
	['<leader>/'] = ':Telescope live_grep theme=ivy vimgrep_arguments=rg,--color=never,--no-heading,--with-filename,--line-number,--column,--smart-case,-u,--hidden<cr>',
	['<leader>gg'] = ':tab G<cr>',
	['<leader>R'] = '<Esc><cmd>lua require("telescope").extensions.refactoring.refactors()<CR>',
	['<leader>T'] = ':Telescope<CR>',
	['<leader>b'] = ':Telescope buffers theme=ivy<cr>',
	['<leader>l'] = ':Telescope current_buffer_fuzzy_find<cr>',
	['<leader>r'] = ':Telescope oldfiles theme=dropdown<cr>',
	['<leader>ih'] = ':Telescope help_tags theme=ivy<cr>',
	['<leader>ik'] = ':Telescope keymaps theme=ivy<cr>',
	['<leader>it'] = ':TSHighlightCapturesUnderCursor<cr>',
	['<leader>ttb'] = ':lua ThemeBloop()<cr>',
	['<leader>ttg'] = ':lua ThemeGhash()<cr>',
	['<leader>ttp'] = ':lua ThemePaperColor()<cr>',
	['<leader>X'] = '<cmd>ped ~/notes/x.md<cr>',
	['<leader>x'] = '<cmd>ped .notes.md<cr>',
	['<leader>cp'] = ':LspFormatting<cr>',
})

noremap.n({
	['<c-l>'] = ':<c-u>:nohlsearch<cr>:pclose<cr><c-l>',
	['<F7>'] = ':FloatermNew<CR>',
	['<F8>'] = ':FloatermPrev<CR>',
	['<F9>'] = ':FloatermNext<CR>',
	['<F12>'] = ':FloatermToggle<CR>',
}, { silent = true })

noremap.t({
	['<F7>'] = [["<C-\><C-n>:FloatermNew<CR>"]],
	['<F8>'] = [["<C-\><C-n>:FloatermPrev<CR>"]],
	['<F9>'] = [["<C-\><C-n>:FloatermNext<CR>"]],
	['<F12>'] = [["<C-\><C-n>:FloatermToggle<CR>"]],
}, { silent = true })

noremap.v({
	['<leader>R'] = '<Esc><cmd>lua require("telescope").extensions.refactoring.refactors()<CR>',
})

noremap.i({
	['jk'] = '<esc>',
	[';;'] = '<Esc>m`A;<esc>``li', -- Easy insertion of a trailing ; from insert mode
	[',,'] = '<Esc>m`A,<esc>``li', -- Easy insertion of a trailing , from insert mode
	})

noremap.c('%%', "getcmdtype() == ':' ? expand('%:h').'/' : '%%'" , { expr = true }) -- type %% in vim's prompt to insert %:h expanded
