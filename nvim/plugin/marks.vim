" Mark words with different highlight groups. So they stand out, independent of
" current search etc. Especially useful for quick scans of logs.
"
" Usage:
"
"   :Mark               ; add word under cursor to hl `mark`: 
"   :Mark <word>        ; add <word> to hl `mark`
"   :Mark!              ; clear *all*
"   :Mark! <word>       ; clear all matches and add <word> to hl `mark`
"   :Danger, :Focus  ; same as :Mark but with different hl groups
"
highlight mark guifg=#ff0000 guibg=#ffff00
highlight danger guifg=#ffffff guibg=#ff0000
highlight focus guifg=#000000 guibg=#00ff00

" command to clear all matches
command! MarkClear :call clearmatches()

command! -nargs=? -bang Mark call s:Mark(<q-args>, <bang>0, 'mark')
command! -nargs=? -bang Danger call s:Mark(<q-args>, <bang>0, 'danger')
command! -nargs=? -bang Focus call s:Mark(<q-args>, <bang>0, 'focus')

function! s:Mark(word, bang, group) abort
  if a:bang
    call clearmatches()
  endif
  if empty(a:word)
    let l:word = expand('<cword>')
  else
    let l:word = a:word
  endif
  if !empty(l:word)
    let l:word = escape(l:word, '\.*$^~[]')
    let l:pattern = '\<' . l:word . '\>'
    call matchadd(a:group, l:pattern)
  endif
endfunction
