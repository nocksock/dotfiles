nmap <buffer> <silent> <f5> :source %<cr>
au InsertLeave *.lua setlocal nolist
au InsertEnter *.lua setlocal list
