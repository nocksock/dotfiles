nmap <buffer> <silent> <f5> :source %<cr>
nmap <buffer> <silent> <leader>bf <Plug>PlenaryTestFile %<cr>
nmap <buffer> <silent> <leader>bd :PlenaryBustedDirectory .<cr>
au InsertLeave *.lua setlocal nolist
au InsertEnter *.lua setlocal list
