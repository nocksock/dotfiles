set guifont=JetBrains\ Mono:h15
syntax on

function! ThemeBloop()
  set background=dark
  colorscheme bloop
endfunction

function! ThemeGhash()
  set background=dark
  colorscheme ghash
endfunction

function! ThemePaperColor()
  set background=light
  colorscheme PaperColor
endfunction

" [i]nfo theme
nnoremap <leader>it :TSHighlightCapturesUnderCursor<cr>  | " note: has a fallback for non TS highlights.

" [t]oggle [t]heme
nnoremap <leader>ttb :call ThemeBloop()<cr>
nnoremap <leader>ttg :call ThemeGhash()<cr>
nnoremap <leader>ttp :call ThemePaperColor()<cr>

call ThemeBloop()
