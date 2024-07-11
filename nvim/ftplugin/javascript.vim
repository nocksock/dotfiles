command! -buffer DeleteLogLines :g/\v\^*console.log/normal dd<cr>

nnoremap <buffer> <M-s> :Prettier<CR>:w<CR>
