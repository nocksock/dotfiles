" Shout (SHell OUT) is a plugin to run shell commands and have the output in
" a buffer.
" Kinda like `:vertical new | read !{cmd}`, but cmd can be a visual selection
" too and the output can be directed to the current buffer below the cursor.
"
" Usage:
"  :Shout {cmd}           run {cmd} and open the result in a new buffer to the side
"  :{range}Shout! {cmd}   passes the {range} via stdin to {cmd} and appends the
"                         result after the visual selection
"  :{range}Shout {cmd}    passes the {range} to {cmd} via stdin and opens the
"                         result in a buffer
"  :Shout! {cmd}          run {cmd} but write the result to the current buffer
"                         (you probably want should use :read !{cmd} instead)

command! -bang -range -nargs=* -complete=shellcmd Shout call shout#run(<bang>0, <q-args>, <line1>, <line2>)

command! -nargs=0 ShMove let prevsearch=@/ | %s#\v(.*)#mv \1 \1# | nohl | let @/=prevsearch
command! -nargs=0 ShInstall let prevsearch=@/ | %s#\v(.*)#install -Dv /dev/null \1# | nohl | let @/=prevsearch
