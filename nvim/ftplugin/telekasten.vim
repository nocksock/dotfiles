nnoremap <buffer> <leader>zy :lua require('telekasten').yank_notelink()<CR>
nnoremap <buffer> <leader>zc :lua require('telekasten').show_calendar()<CR>
nnoremap <buffer> <leader>zC :CalendarT<CR>
nnoremap <buffer> <leader>zi :lua require('telekasten').paste_img_and_link()<CR>
nnoremap <buffer> <leader>z<cr> :lua require('telekasten').toggle_todo()<CR>
nnoremap <buffer> <leader>zb :lua require('telekasten').show_backlinks()<CR>
nnoremap <buffer> <leader>zF :lua require('telekasten').find_friends()<CR>
nnoremap <buffer> <leader>zI :lua require('telekasten').insert_img_link({ i=true })<CR>
nnoremap <buffer> <leader>zp :lua require('telekasten').preview_img()<CR>
nnoremap <buffer> <leader>zm :lua require('telekasten').browse_media()<CR>
nnoremap <buffer> <leader># :lua require('telekasten').show_tags()<CR>

inoremap <buffer> <silent> #: <cmd>lua require('telekasten').show_tags({i = true})<cr>
inoremap [[ <cmd>:lua require('telekasten').insert_link({ i=true })<CR>

hi link CalNavi CalRuler
hi tkTagSep ctermfg=gray guifg=gray
hi tkTag ctermfg=175 guifg=#d3869B
