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

call ThemeBloop()
