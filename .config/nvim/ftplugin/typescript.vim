autocmd BufEnter *.{ts,tsx} :syntax sync fromstart " force vim to parse the *entire* file from start.
autocmd BufLeave *.{ts,tsx} :syntax sync clear
nmap <localleader>s :e %:r:r.stories.ts<cr>
nmap <localleader>t :e %:r:r.spec.ts<cr>
nmap <localleader>m :e %:r:r.ts<cr>
