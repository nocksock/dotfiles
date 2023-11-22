" setlocal textwidth=80
setlocal fo-=t " do not autowrap text at width
setlocal wrap
setlocal linebreak
setlocal listchars+=precedes:<,extends:>
setlocal breakindent
setlocal breakindentopt=shift:4,sbr,list:2

nmap <buffer> <silent> <f5> :Glow %<cr>
