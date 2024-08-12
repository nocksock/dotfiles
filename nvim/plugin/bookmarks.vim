command! Config tabedit ~/.config/nvim | silent tcd ~/.config/nvim
command! Keymap tabedit ~/.config/nvim/plugin/keymap.vim | silent tcd ~/.config/nvim
command! LspConfig tabedit ~/.config/nvim/plugin/lsp-cmp.lua | silent tcd ~/.config/nvim
command! Plugins exec("tabedit " .. g:baggage_path .. " | silent tcd " .. g:baggage_path)
