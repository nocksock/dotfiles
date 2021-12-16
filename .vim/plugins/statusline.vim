function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction

function! SomeText(nr)
    let activebuffer = (a:nr == win_getid()) ? "Active Window" : "None Current Window"
    let buf_type = &buftype
    return activebuffer." & ".buf_type
endfun

function CustomStatusLineFn(nr) 
    if a:nr == win_getid()
      return '%#StatusLine#%f %m %= %#StatusLine# %y %{&fileencoding?&fileencoding:&encoding} %{&fileformat} %p%% %l:%c'
    endif

    return '%#StatusLineNC#%f'
endfunction

function! CustomStatusLine() abort
    let startup_win_id = win_getid()
    let s = '%{CustomStatusLineFn(".startup_win_id.")} '.startup_win_id
    return s
endfun


" set statusline=%!CustomStatusLine()

" set statusline=
" set statusline+=%#PmenuSel#
" set statusline+=%{StatuslineGit()}
" set statusline+=%#LineNr#
" set statusline+=\ %f
" set statusline+=%m

" set statusline+=%=

" set statusline+=%#Statusline#
" set statusline+=\ %y
" set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
" " set statusline+=\[%{&fileformat}\]
" set statusline+=\ %p%%
" set statusline+=\ %l:%c
" set statusline+=\ 

