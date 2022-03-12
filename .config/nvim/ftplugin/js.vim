autocmd BufEnter *.{js,jsx} :syntax sync fromstart " force vim to parse the *entire* file from start.
autocmd BufLeave *.{js,jsx} :syntax sync clear
