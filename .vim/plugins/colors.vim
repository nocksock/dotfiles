" " has a nice dark and light theme
Plug '~/projects/bloop-vim'

function! SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

noremap <leader>ts :call SynStack()<cr>

autocmd User Plugloaded colors bloop
