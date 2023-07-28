fun! RelativeComplete(A,L,P)
  return readdir(getcwd()) + ['..']
endfun

command! Sh Shout
command! -nargs=* -complete=shellcmd Shout vertical new | execute("read ! <args>") | normal ggdd | setlocal buftype=nofile

command! -nargs=0 PrepMove let prevsearch=@/ | %s#\v(.*)#mv \1 \1# | nohl | let @/=prevsearch
command! -nargs=0 PrepInstall let prevsearch=@/ | %s#\v(.*)#install -Dv /dev/null \1# | nohl | let @/=prevsearch
