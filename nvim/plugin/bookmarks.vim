command! Config tabedit ~/.config/nvim | silent tcd ~/.config/nvim
command! Plugins exec("tabedit " .. g:baggage_path .. " | silent tcd " .. g:baggage_path)
