 setlocal textwidth=80
 setlocal fo+=t " auto wrap at text width
 nmap <buffer> <silent> <f5> :call jobstart('tmux display-popup -E -w 80% -h 80% "glow % -p"')<cr>
