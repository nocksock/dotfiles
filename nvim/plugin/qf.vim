command! Cbuffer call setqflist(map(getbufline('%', 1, '$'), {_, f -> {'filename': f, 'lnum': 1, 'col': 1}})) | copen

command! -nargs=* Cfind call s:CFind(<f-args>)

function! s:CFind(...) abort
  let l:args = a:000
  let l:cmd = 'fd --color=never'

  if len(l:args) > 0
    let l:cmd .= ' "' . join(l:args, ' ') . '" .'
  endif

  let l:lines = split(system(l:cmd), '\n')
  if empty(l:lines)
    echo "No results"
    return
  endif

  let l:qf = map(l:lines, {_, f -> {'filename': f, 'lnum': 1, 'col': 1}})
  call setqflist(l:qf, 'r')
  copen
endfunction
