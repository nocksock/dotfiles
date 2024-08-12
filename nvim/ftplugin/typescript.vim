runtime! ftplugin/javascript.vim

compiler tsc
setlocal makeprg=pnpm\ exec\ tsc\ --noEmit
setlocal fdm=marker

nmap <buffer> <leader>ci :TSToolsAddMissingImports<cr>:w<cr>
nmap <buffer> <leader>ca :EslintFixAll<cr>:w<cr>
