" :E to edit/create file relative to the current buffer
command! -nargs=1 -complete=customlist,RelativeComplete E edit %:h/<args>
" :W to write file relative to the current buffer
command! -nargs=1 -complete=customlist,RelativeComplete W write %:h/<args>

fun! RelativeComplete(A,L,P)
  return readdir(expand('%:h')) + ['..']
endfun

