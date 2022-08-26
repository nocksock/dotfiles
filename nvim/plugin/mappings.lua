local function map(mode, key, command, opts)
  opts = vim.tbl_extend('force', { noremap = true, silent = true }, opts or {})
  vim.keymap.set(mode, key, command, opts)
end

local gitsigns = require('gitsigns.actions')

-- git mappings {{{
map('n', '<leader>gg', ':tab G<cr>')
map('n', ']h', "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", { expr = true })
map('n', '[h', "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", { expr = true })
local function hunk(suffix) return { desc = "[h]unk " .. suffix } end
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
-- }}}

-- Telescope {{{
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
end --}}}

map('n', '<leader><space>', ":lua require('telescope.builtin').buffers()<cr>", { desc = '[ ] Find existing buffers' })
map('n', '<leader><cr>', ":lua require('telescope.builtin').resume()<cr>", { desc = '[] resume previous search'})
map('n', '<leader>rf', ":lua require('refactoring').select_refactor()<CR>")
map('n', '<leader>sC', ":lua require('telescope.builtin').colorscheme({ enable_preview = true })<cr>",
  { desc = "[s]earch [C]olorschemes" })
map('n', '<leader>T', ":lua require('telescope.builtin').builtin()<cr>", { desc = 'builtin [T]elescope commands' })
map('n', '<leader>sf', search_in(nil), { desc = '[s]earch [f]iles' })
map('n', '<leader>s.', search_in("%:p:h"), { desc = '[s]earch files in current directory ([.]/)' })
map('n', '<leader>sdf', search_in(vim.fn.getenv('DOTDIR')), { desc = '[s]earch [d]ot[f]iles' })
map('n', '<leader>sr', ":lua require('telescope.builtin').oldfiles()<cr>", { desc = '[s]earch [r]ecently opened files' })
map('n', '<leader>sh', ":lua require('telescope.builtin').help_tags()<cr>", { desc = '[s]earch [h]elp' })
map('n', '<leader>sk', ":lua require('telescope.builtin').keymaps()<cr>", { desc = '[s]earch [k]eymaps' })
map('n', '<leader>sl', ":lua require('telescope.builtin').loclist()<cr>", { desc = '[s]earch [l]oclist' })
map('n', '<leader>sc', ":lua require('telescope.builtin').commands()<cr>", { desc = '[s]earch [c]ommands' })
map('n', '<leader>sw', ":lua require('telescope.builtin').grep_string()<cr>", { desc = '[s]earch current [w]ord' })
map('n', '<leader>sg', ":lua require('telescope.builtin').live_grep()<cr>", { desc = '[s]earch by [g]rep' })
map('n', '<leader>gb', ':Telescope git_branches theme=dropdown<cr>')
map('n', '<leader>/', ':lua require("telescope.builtin").current_buffer_fuzzy_find()<cr>',
  { desc = '[/] Fuzzily search in current buffer' })
map('n', '<leader>sp', ":lua R('search-plugins').search()<cr>", { desc = '[s]earch [p]lugins'})
map('n', '<leader>sdb', ":lua require('telescope.builtin').diagnostics({ bufnr = 0 })<cr>",
  { desc = '[s]earch [d]iagnostics current [b]uffer' })
map('n', '<leader>sdw', ":lua require('telescope.builtin').diagnostics()<cr>",
  { desc = '[s]earch [d]iagnostics [w]orkspace' })
map('n', '<leader>M', '<cmd>Messages<cr>', { desc = "[M]essages"})

-- buffers
map('n', '<leader>bd', ':b#|bd#<cr>', { desc = "[B]uffer [D]elete" }) -- delete buffer without messing up window layout
map('n', '<leader>bD', ':bd', { desc = "[B]uffer [D]elete" })
map('n', '<leader>bO', ':%bd|e#<cr>', { desc = "[B]uffer [O]nly" })
map('n', ']b', ':bn<cr>', { desc = "[B]uffer [n]ext" })
map('n', '[b', ':bp<cr>', { desc = "[B]uffer [p]revious" })
map('n', '<leader>1', ':LualineBuffersJump 1<cr>', { desc = "[B]uffer Number 1" })
map('n', '<leader>2', ':LualineBuffersJump 2<cr>', { desc = "[B]uffer Number 2" })
map('n', '<leader>3', ':LualineBuffersJump 3<cr>', { desc = "[B]uffer Number 3" })
map('n', '<leader>4', ':LualineBuffersJump 4<cr>', { desc = "[B]uffer Number 4" })
map('n', '<leader>5', ':LualineBuffersJump 5<cr>', { desc = "[B]uffer Number 5" })
map('n', '<leader>6', ':LualineBuffersJump 6<cr>', { desc = "[B]uffer Number 6" })
map('n', '<leader>7', ':LualineBuffersJump 7<cr>', { desc = "[B]uffer Number 7" })
map('n', '<leader>8', ':LualineBuffersJump 8<cr>', { desc = "[B]uffer Number 8" })
map('n', '<leader>9', ':LualineBuffersJump 9<cr>', { desc = "[B]uffer Number 9" })

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
map('n', "'f", ':lua require("harpoon.ui").nav_file(1)<CR>')
map('n', "'d", ':lua require("harpoon.ui").nav_file(2)<CR>')
map('n', "'s", ':lua require("harpoon.ui").nav_file(3)<CR>')
map('n', "'a", ':lua require("harpoon.ui").nav_file(4)<CR>')

-- harpoon: cmd
map('n', '""', ':lua require("harpoon.cmd-ui").toggle_quick_menu()<CR>')

-- zettelkasten
local zettel = function(desc)
  return { desc = "[Z]ettel " .. desc }
end
map('n', '<leader>zf', ':lua require("zettel").find_notes()<cr>', zettel('[f]ind notes'))
map('n', '<leader>zd', ':lua require("zettel").find_daily_notes()<cr>', zettel('find [d]aily notes'))
map('n', '<leader>zg', ':lua require("zettel").search_notes()<cr>', zettel('[g]rep notes'))
map('n', '<leader>zz', ':lua require("zettel").follow_link()<cr>', zettel('[z] follow link'))
map('n', '<leader>zt', ':lua require("zettel").goto_today()<cr>', zettel('goto [t]oday'))
map('n', '<leader>zW', ':lua require("zettel").goto_thisweek()<cr>', zettel('goto this [W]eek'))
map('n', '<leader>zw', ':lua require("zettel").find_weekly_notes()<cr>', zettel('find [w]eekly notes'))
map('n', '<leader>zn', ':lua require("zettel").new_note()<cr>', zettel('[n]ew note'))
map('n', '<leader>zN', ':lua require("zettel").new_templated_note()<cr>', zettel('[N]ew templated note'))

map('n', '<F12>', ':Ts<CR>i')
map('t', '<F12>', [[<C-\><C-n>:T<CR>]])

map('n', '<c-0>', ':NvimTreeFindFileToggle<CR>')
map('n', '<leader>tff', ':NvimTreeFindFileToggle<CR>', { desc = "[t]ree [f]ind [t]oggle" })
map('n', '<leader>tt', ':NvimTreeToggle<CR>', { desc = "[t]ree [t]oggle" })

map('n', '<leader>xd', ':Trouble document_diagnostics<CR>', { desc = "show [d]ocument_diagnostics" })
map('n', '<leader>xD', ':Trouble workspace_diagnostics<CR>', { desc = "show workspace_[D]iagnostics" })
map('n', '<leader>xt', ':TodoTrouble<CR>', { desc = "[t]ree [t]oggle" })

-- misc convenience {{{
map('n', '<leader>sns', ':source ~/.config/nvim/plugin/completion.lua<cr>', { desc = "[sn]ippet [s]ource" })
map('n', 'j', [[(v:count > 5 ? "m'" . v:count : "") . 'gj']], { expr = true }) -- when moving more than 5 lines, then make a jump, to be able to revert via c-o
map('n', 'k', [[(v:count > 5 ? "m'" . v:count : "") . 'gk']], { expr = true })
map('n', 'gx', ":execute '!open ' . shellescape(expand('<cWORD>'), 1)<cr>")
map('n', 'gV', '`[v`]') -- visual select last inserted text)
map('n', '<leader>dts', [[mz:%s/ \+$//<cr>`z<cr>]]) -- delete trailing spaces
map('n', '<leader>cp', ':LspFormatting<cr>')
map('n', '<leader>.', ':LspCodeAction<cr>')
map('n', '<leader>cl', ':<c-u>:nohlsearch<cr>:pclose<cr><c-l>', { desc = "[cl]ear display" })
map('n', '<leader>tl', ':lua require("lsp_lines").toggle()<cr>', { desc = "[t]oggle [l]sp lines" })
map('n', '<leader>tn', ':LineNrToggle<CR>', { desc = "[t]oggle line [n]umbers" })
map('n', '<leader>to', ':SymbolsOutline<cr>', { desc = "[t]oggle [o]utline" })
map('n', '<leader>gc', 'yygccp')
map('n', '<leader>gC', '')
-- }}}

map({ 'i', 'n' }, '<M-s>', '<cmd>:w<cr>')

-- window navigation {{{
map('n', '<c-j>', '<c-w>j')
map('n', '<c-k>', '<c-w>k')
map('n', '<c-l>', '<c-w>l')
map('n', '<c-h>', '<c-w>h')
map('n', '<c-n>', 'gt')
map('n', '<c-p>', 'gT')
map('n', '<M-j>', ']d')
map('n', '<M-k>', '[d')
--}}}

-- better terminal exits
-- terminal {{{
map('t', '<c-[>', '<C-\\><C-n>')
map('t', '<Esc>', '<C-\\><C-n>')
-- }}}

-- misc: more undo stops in insert mode {{{
map('i', '!', '!<c-g>u')
map('i', '.', '.<c-g>u')
map('i', ':', ':<c-g>u')
map('i', ';', ';<c-g>u')
map('i', '?', '?<c-g>u')
map('i', ',', ',<c-g>u')
--}}}

-- misc: move text around
map('v', '<C-k>', ":m '<-2<CR>gv=gv")
map('v', '<C-j>', ":m '>+1<CR>gv=gv")

-- type %% in vim's prompt to insert %:h expanded
vim.cmd([[cnoremap <expr> %%  getcmdtype() == ':' ? expand('%:h').'/' : '%%']])
