" Zoom / Restore window {{{
" credit: https://stackoverflow.com/questions/13194428/is-better-way-to-zoom-windows-in-vim-than-zoomwin/26551079#26551079
" function! s:ZoomToggle() abort
"     if exists('t:zoomed') && t:zoomed
"         execute t:zoom_winrestcmd
"         let t:zoomed = 0
"     else
"         let t:zoom_winrestcmd = winrestcmd()
"         resize
"         vertical resize
"         let t:zoomed = 1
"     endif
" endfunction
" command! ZoomToggle call s:ZoomToggle()

" nnoremap <silent> <C-A> :ZoomToggle<CR>
" }}}
