" Plug 'peitalin/vim-jsx-typescript'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }            " syntax hilighting in styled`` template literals

let g:vim_jsx_pretty_highlight_close_tag = 1

" force vim to parse the *entire* file from start. should fix seemingly
" unmatched braces etc.
autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear

augroup ft_javascript
    au!
    au FileType javascript setlocal foldmethod=marker
    au FileType javascript setlocal foldmarker={,}
    au FileType javascript :au InsertLeave *.js setlocal nolist
    au FileType javascript :au InsertEnter *.js setlocal list
augroup END
