setlocal formatprg=prettier\ --parser\ typescript\ --stdin-filepath\ %
setlocal formatexpr=  " reset Fixedgq from polyglot
nmap <localleader>t :e %:r:r.spec.ts<cr>
nmap <localleader>m :e %:r:r.ts<cr>
