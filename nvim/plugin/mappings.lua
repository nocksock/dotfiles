local function map(mode, key, command, opts)
  opts = vim.tbl_extend('force', { noremap = true, silent = true }, opts or {})
  vim.keymap.set(mode, key, command, opts)
end

local gitsigns = require('gitsigns.actions')

---prefix HOF
---@param s string
local prefix = function(s)
  return function(suffix)
    return { desc = s .. " " .. suffix }
  end
end

-- leader prefixes
local b = prefix "[b]uffer"
local d = prefix "[d]ebug"
local h = prefix "[h]unk"
local s = prefix "[s]earch"
local t = prefix "[t]oggle"
local x = prefix "[x] globals"
local z = prefix "[z]ettel"


local mode = function(mode)
  return function(lhs)
    return function(rhs)
      return function(opts)
        map(mode, lhs, rhs, opts)
      end
    end
  end
end

-- local nmap = mode 'n'
-- local vmap = mode 'v'
--
-- nmap "<leader>?" ":Telescope help_tags<cr>" (s "[h]elp")

-- git mappings {{{
-- map('n', '<leader>gg', ':tab G<cr>')
map('n', ']h', "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", { expr = true })
map('n', '[h', "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", { expr = true })
map('n', '<leader>hs', gitsigns.stage_hunk, h '[s]tage')
map('v', '<leader>hs', gitsigns.stage_hunk, h '[s]tage')
map('n', '<leader>hr', gitsigns.reset_hunk, h '[r]eset')
map('v', '<leader>hr', gitsigns.reset_hunk, h '[r]eset')
map('n', '<leader>hu', gitsigns.undo_stage_hunk, h '[U]ndo stage')
map('n', '<leader>hS', gitsigns.stage_buffer, h '[S]tage buffer')
map('n', '<leader>hR', gitsigns.reset_buffer, h '[R]eset buffer')
map('n', '<leader>hp', gitsigns.preview_hunk)
map('n', '<leader>hb', ':lua require"gitsigns".blame_line{full=true}<CR>')
map('n', '<leader>hd', gitsigns.diffthis)
map('n', '<leader>hD', ':lua require"gitsigns".diffthis("~")<CR>')
map('o', 'ih', gitsigns.select_hunk)
map('x', 'ih', gitsigns.select_hunk)
-- }}}

local st = ":lua require('snock.telescope')"

map('n' , '<leader><space>' , st .. ".buffers()<cr>"                                     , { desc = '[ ] Find existing buffers' })
map('n' , '<leader><cr>'    , st .. ".resume()<cr>"                                      , { desc = '[] resume previous search' })
map('n' , '<leader>T'       , st .. ".builtin()<cr>"                                     , { desc = 'builtin [T]elescope commands' })
map('n' , '<leader>rf'      , ":lua require('snock.refactoring').select_refactor()<CR>")

map('n' , '<leader>sC'      , st .. ".colorscheme({ enable_preview = true })<cr>"        , s("[C]olors"))
map('n' , '<leader>sf'      , st .. ".search_in(nil)<cr>"                                , s('[f]iles'))
map('n' , '<leader>sdf'     , st .. ".search_in(vim.fn.getenv('DOTDIR'))<cr>"            , s('[d]ot[f]iles'))
map('n' , '<leader>sr'      , st .. ".oldfiles()<cr>"                                    , s('[r]ecently opened files'))
map('n' , '<leader>sh'      , st .. ".help_tags()<cr>"                                   , s('[h]elp'))
map('n' , '<leader>sk'      , st .. ".keymaps()<cr>"                                     , s('[k]eymaps'))
map('n' , '<leader>sl'      , st .. ".loclist()<cr>"                                     , s('[l]oclist'))
map('n' , '<leader>sc'      , st .. ".commands()<cr>"                                    , s('[c]ommands'))
map('n' , '<leader>sw'      , st .. ".grep_string()<cr>"                                 , s('current [w]ord'))
map('n' , '<leader>sg'      , st .. ".live_grep()<cr>"                                   , s('by [g]rep'))
map('n' , '<leader>gb'      , st .. ".git_branches()<cr>")
map('n' , '<leader>/'       , st .. '.current_buffer_fuzzy_find()<cr>'                   , { desc = '[/] Fuzzily search in current buffer' })
map('n' , '<leader>sp'      , ":lua R('search-plugins').search()<cr>"                    , s('[p]lugins'))

map('n' , '<leader>bd' , ':b#|bd#<cr>'               , b("[D]elete    , keep layout"))
map('n' , '<leader>bD' , ':bd'                       , b("[D]elete"))
map('n' , '<leader>bO' , ':%bd|e#<cr>'               , b("[O]nly"))
map('n' , '<leader>1'  , ':LualineBuffersJump 1<cr>' , b("#1"))
map('n' , '<leader>2'  , ':LualineBuffersJump 2<cr>' , b("#2"))
map('n' , '<leader>3'  , ':LualineBuffersJump 3<cr>' , b("#3"))
map('n' , '<leader>4'  , ':LualineBuffersJump 4<cr>' , b("#4"))
map('n' , '<leader>5'  , ':LualineBuffersJump 5<cr>' , b("#5"))
map('n' , '<leader>6'  , ':LualineBuffersJump 6<cr>' , b("#6"))
map('n' , '<leader>7'  , ':LualineBuffersJump 7<cr>' , b("#7"))
map('n' , '<leader>8'  , ':LualineBuffersJump 8<cr>' , b("#8"))
map('n' , '<leader>9'  , ':LualineBuffersJump 9<cr>' , b("#9"))

-- infos
map('n' , '<leader>it' , ':TSHighlightCapturesUnderCursor<cr>')
map('n' , '<leader>id' , '<Plug>:LspDiagLine<cr>')

-- toggles
map('n' , '<leader>te' , ':NnnExplorer<cr>'       , t('[e]xplorer (nnn)'))
map('n' , '<leader>tE' , ':NnnExplorer %:p:h<cr>' , t('[E]xplorer in buffer folder (nnn)'))
map('n' , '_'          , ':NnnPicker %:p:h<cr>')
map('n', '<leader>tb', ':DapToggleBreakpoint<cr>', t('[b]reakpoint'))

-- harpoon: nav_file
map('n' , "<leader>'" , ':lua require("harpoon.mark").add_file()<CR>')
map('n' , "''"        , ':lua require("harpoon.ui").toggle_quick_menu()<CR>')
map('n' , "'f"        , ':lua require("harpoon.ui").nav_file(1)<CR>')
map('n' , "'d"        , ':lua require("harpoon.ui").nav_file(2)<CR>')
map('n' , "'s"        , ':lua require("harpoon.ui").nav_file(3)<CR>')
map('n' , "'a"        , ':lua require("harpoon.ui").nav_file(4)<CR>')

-- harpoon: cmd
map('n', '""', ':lua require("harpoon.cmd-ui").toggle_quick_menu()<CR>')
map('n', '"1', ':lua require("harpoon.tmux").gotoTerminal(1)<CR>')
map('n', '"2', ':lua require("harpoon.tmux").gotoTerminal(2)<CR>')

-- zettelkasten
local zettel = ':lua require("zettel")'
map('n' , '<leader>zf' , zettel .. '.find_notes()<cr>'         , z('[f]ind notes'))
map('n' , '<leader>zd' , zettel .. '.find_daily_notes()<cr>'   , z('find [d]aily notes'))
map('n' , '<leader>zg' , zettel .. '.search_notes()<cr>'       , z('[g]rep notes'))
map('n' , '<leader>zz' , zettel .. '.follow_link()<cr>'        , z('[z] follow link'))
map('n' , '<leader>zt' , zettel .. '.goto_today()<cr>'         , z('goto [t]oday'))
map('n' , '<leader>zW' , zettel .. '.goto_thisweek()<cr>'      , z('goto this [W]eek'))
map('n' , '<leader>zw' , zettel .. '.find_weekly_notes()<cr>'  , z('find [w]eekly notes'))
map('n' , '<leader>zn' , zettel .. '.new_note()<cr>'           , z('[n]ew note'))
map('n' , '<leader>zN' , zettel .. '.new_templated_note()<cr>' , z('[N]ew templated note'))

map('n', '<F12>', ':Ts<CR>i')
map('t', '<F12>', [[<C-\><C-n>:T<CR>]])

map('n' , '<c-0>'      , ':lua require("snock.filetree").find_file()<CR>')
map('n' , '<leader>tt' , ':lua require("snock.filetree").toggle()<CR>'     , { desc = "[t]ree [t]oggle" })

map('n' , '<leader>xd' , ':Trouble document_diagnostics<CR>'  , x "show [d]ocument_diagnostics")
map('n' , '<leader>xD' , ':Trouble workspace_diagnostics<CR>' , x "show workspace_[D]iagnostics")
map('n' , '<leader>xt' , ':TodoTrouble<CR>'                   , x "[t]ree [t]oggle")

-- misc convenience {{{
map('n' , '<leader>sns' , ':source ~/.config/nvim/plugin/completion.lua<cr>'    , { desc = "[sn]ippet [s]ource" })
map('n' , 'j'           , [[(v:count > 5 ? "m'" . v:count : "") . 'gj']]        , { expr = true }) -- when moving more than 5 lines , then make a jump , to be able to revert via c-o
map('n' , 'k'           , [[(v:count > 5 ? "m'" . v:count : "") . 'gk']]        , { expr = true })
map('n' , 'gx'          , ":execute '!open ' . shellescape(expand('<cWORD>')    , 1)<cr>")
map('n' , 'gV'          , '`[v`]') -- visual select last inserted text)
map('n' , '<leader>M'   , '<cmd>Messages<cr>'                                   , { desc = "[M]essages" })
map('n' , '<leader>dts' , [[mz:%s/ \+$//<cr>`z<cr>]]) -- delete trailing spaces
map('n' , '<leader>cp'  , ':LspFormatting<cr>')
map('n' , '<leader>.'   , ':LspCodeAction<cr>')
map('n' , '<leader>cl'  , ':<c-u>:nohlsearch<cr>:pclose<cr><c-l>'               , { desc = "[cl]ear display" })
map('n' , '<leader>tl'  , ':lua require("lsp_lines").toggle()<cr>'              , { desc = "[t]oggle [l]sp lines" })
map('n' , '<leader>tn'  , ':LineNrToggle<CR>'                                   , { desc = "[t]oggle line [n]umbers" })
map('n' , '<leader>to'  , ':SymbolsOutline<cr>'                                 , { desc = "[t]oggle [o]utline" })
map('n' , '<leader>gc'  , 'yygccp')
map('n' , '<leader>gC'  , '')
map('n', 'z0', 'zMzv') -- close all other folds
-- }}}

map({ 'i', 'n' }, '<M-s>', '<cmd>:w<cr>')

-- window navigation {{{
map('n' , '<c-j>' , '<c-w>j')
map('n' , '<c-k>' , '<c-w>k')
map('n' , '<c-l>' , '<c-w>l')
map('n' , '<c-h>' , '<c-w>h')
map('n' , '<c-n>' , 'gt')
map('n' , '<c-p>' , 'gT')
map('n' , '<M-j>' , ']d')
map('n' , '<M-k>' , '[d')
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

-- debuggin
map('n', '<leader>dc', ':DapContinue<cr>', d("[c]ontinue"))
map('n', '<leader>du', ':lua require("dapui").toggle()<cr>', d("[u]i toggle"))
-- vim: nowrap
