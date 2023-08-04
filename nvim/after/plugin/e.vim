command! -nargs=1 -complete=customlist,RelativeComplete E edit %:h/<args>

fun! RelativeComplete(A,L,P)
  return readdir(expand('%:h')) + ['..']
endfun
