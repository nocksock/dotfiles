" setlocal textwidth=80
setlocal fo-=tc " do not autowrap text at width
setlocal wrap
setlocal linebreak
setlocal listchars+=precedes:<,extends:>
setlocal breakindent
setlocal breakindentopt=shift:4,sbr,list:2
setlocal textwidth=0
setlocal wrapmargin=0

nmap <buffer> <silent> <f5> :Glow %<cr>
