setlocal textwidth=80
setlocal fo+=t " auto wrap at text width
setlocal wrap
setlocal linebreak
setlocal listchars+=precedes:<,extends:>

nmap <buffer> <silent> <f5> :Glow %<cr>
