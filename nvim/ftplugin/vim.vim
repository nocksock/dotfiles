  setlocal iskeyword+=-

  nnoremap <buffer> <silent> gx :call <sid>plug_gx()<cr>
  nnoremap <F2> :execute getline(".")<cr>
  vnoremap <F2> :<c-u>exe join(getline("'<","'>"),'<bar>')<cr>
  nnoremap <F5> :source %<cr>

