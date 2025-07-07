  setlocal iskeyword+=-

  nnoremap <buffer> <silent> gx :call <sid>plug_gx()<cr>
  nnoremap <buffer> <F2> :execute getline(".")<cr>
  vnoremap <buffer> <F5> :<c-u>exe join(getline("'<","'>"),'<bar>')<cr>
  nnoremap <buffer> <F5> :source %<cr>

