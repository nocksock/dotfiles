set guifont=JetBrains\ Mono:h15
syntax on
colorscheme bloop

" note: this is not working with tree-sitter capture groups.
" nvim-treesitter ships with :TSHighlightCapturesUnderCursor
function! SynInfo()
  let l:s = synID(line('.'), col('.'), 1)
  echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfun

" TODO: check if treesitter highlights are enabled an run the correct function
nnoremap <leader>iv :call SynInfo()<cr>
nnoremap <leader>it :TSHighlightCapturesUnderCursor<cr>

nnoremap <leader>ttb :colorscheme bloop<cr>
nnoremap <leader>ttg :colorscheme ghash<cr>
