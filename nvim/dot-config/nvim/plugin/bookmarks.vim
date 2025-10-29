command! Config tabedit $DOTDIR/nvim/dot-config/nvim | silent tcd $DOTDIR/nvim/dot-config/nvim
command! Keymap tabedit $DOTDIR/nvim/dot-config/nvim/plugin/keymap.vim | silent tcd $DOTDIR/nvim/dot-config/nvim
command! Plugins exec("tabedit " .. g:baggage_path .. " | silent tcd " .. g:baggage_path)
