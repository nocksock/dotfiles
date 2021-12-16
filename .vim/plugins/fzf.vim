Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }                             " fzf <3 rip ctrlp
Plug 'junegunn/fzf.vim'

" git branches etc
Plug 'stsewd/fzf-checkout.vim' 


let g:fzf_layout = { 'up': '~90%', 'window': { 'width': 0.8, 'height': 0.8, 'yoffset':0.5, 'xoffset': 0.5 } }
let g:fzf_preview_window = ['up:50%', 'ctrl-/']

let $FZF_DEFAULT_OPTS = '--layout=reverse --info=inline'


command! FF call fzf#run(fzf#wrap({'source' : 'find .'}))

" use rg which respects .gitignore files
command! -bang -nargs=? -complete=dir Files
    \ call fzf#run(fzf#wrap('files', fzf#vim#with_preview({ 'dir': <q-args>, 'sink': 'e', 'source': 'rg --files --hidden' }), <bang>0))

" Add an AllFiles command that disrepsects .gitignore files
command! -bang -nargs=? -complete=dir AllFiles
    \ call fzf#run(fzf#wrap('allfiles', fzf#vim#with_preview({ 'dir': <q-args>, 'sink': 'e', 'source': 'rg --files --hidden --no-ignore' }), <bang>0))

nnoremap <leader><space> :Files<cr>
nnoremap <leader>ff :Files<cr>
nnoremap <leader>fa :AllFiles<cr>
noremap <leader>fr :History<cr>
noremap <leader>fl :Lines<cr>
noremap <leader>ft :Tags<cr>
noremap <leader>hh :Helptags<cr>
noremap <leader>ss :Ag<cr>
noremap <leader>bb :Buffers<cr>
noremap <leader>sn :Snippets<cr>
nmap <leader>gb :GBranches<cr>

" muscle memory keeper for vscode moments
noremap <c-p> :Files<cr> 
