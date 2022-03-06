set guifont=JetBrains\ Mono:h15
syntax on
colorscheme bloop

function! SynInfo()
  let l:s = synID(line('.'), col('.'), 1)
  echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfun

nnoremap <leader>it :call SynInfo()<cr>
