nnoremap <silent> - <ESC>:lua require('telekasten').toggle_todo()<CR>
inoremap <silent> [[ <ESC>:lua require('telekasten').insert_link({ i=true })<CR>
inoremap <silent> ## <cmd>lua require('telekasten').show_tags({i = true})<cr>
