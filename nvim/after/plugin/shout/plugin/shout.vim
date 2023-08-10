command! -bang -range -nargs=* -complete=shellcmd Shout call shout#run(<bang>0, <q-args>, <line1>, <line2>)

command! -nargs=0 PrepMove let prevsearch=@/ | %s#\v(.*)#mv \1 \1# | nohl | let @/=prevsearch
command! -nargs=0 PrepInstall let prevsearch=@/ | %s#\v(.*)#install -Dv /dev/null \1# | nohl | let @/=prevsearch
