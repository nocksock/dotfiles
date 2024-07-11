runtime! ftplugin/javascript.vim

compiler tsc
setlocal makeprg=pnpm\ --package=typescript\ dlx\ tsc\ --noEmit

setlocal fdm=marker

nmap <buffer> <c-f>i :TSToolsAddMissingImports<cr>:w<cr>
nmap <buffer> <c-f>e :EslintFixAll<cr>:w<cr>
nmap  <c-i> :TSToolsAddMissingImports<cr>:w<cr>
nmap  <c-e> :EslintFixAll<cr>:w<cr>
