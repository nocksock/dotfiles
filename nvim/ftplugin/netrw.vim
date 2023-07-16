setlocal fillchars=eob:\ 

silent nmap <buffer> a <nop>
silent nmap <buffer> D <nop>
silent vmap <buffer> D <nop>
silent nmap <buffer> <Del> <nop>
silent vmap <buffer> <Del> <nop>

nnoremap <buffer><silent> <c-c> :<C-u>bd!<CR>
