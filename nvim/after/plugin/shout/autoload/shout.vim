if exists('g:autoloaded_shout')
  finish
endif
let g:autoloaded_shout = 1

function! shout#run(bang, cmd, line1, line2) range
  let stdin = []
  let has_range = a:line1 && a:line2
  let has_cmd = a:cmd != ''

  if !has_range && !has_cmd
    error("No command given")
    return
  end

  if has_range && has_cmd
    let stdin = getline(a:line1, a:line2)
    let cmd = a:cmd
    let end = a:line2

  elseif has_cmd
    let end = line('.')

  elseif has_range
    let cmd = "zsh"
    let stdin = getline(a:line1, a:line2)
    let end = a:line2
  endif

  if a:bang
    let end = a:line2 ? a:line2 : line('.')
    call append(a:line2, "")
    call append(a:line2+1,  "$ " .l:cmd . " - ")
    call setpos('.', [0, a:line2+2, 1, 0])
  else
    vertical new
    setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap ft=terminal
    nnoremap <buffer> q <cmd>bd!<cr>
    let end = line(0)
  endif

  let jobid = jobstart(l:cmd, {
        \ 'stdout_buffered': 1,
        \ 'stderr_buffered': 1,
        \ 'on_stderr': { j,d,e -> append(line('.'),d)},
        \ 'on_stdout': { j,d,e -> append(line('.'),d)}})

  call chansend(l:jobid, l:stdin)
  call chanclose(l:jobid, "stdin")

endfunction
