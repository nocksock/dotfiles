nmap <buffer> <silent> <f5> :source %<cr>
nmap <buffer> <silent> <leader>t <Plug>PlenaryTestFile
au InsertLeave *.lua setlocal nolist
au InsertEnter *.lua setlocal list
