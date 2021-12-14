" has a nice dark and light theme
Plug 'nocksock/ayu-vim'

" Theme light/dark switch
let ayucolor="dark"

function! ToggleLight(mode)
  if a:mode == "light" 
    " set background=dark
    return "dark"
  else 
    " set background=light
    return "light"
  endif
endfunction

noremap <leader>tl :let ayucolor=ToggleLight(ayucolor)<cr>:colors ayu<cr>TransparentBG()<cr>
