runtime! ftplugin/javascript.vim

compiler tsc
setlocal makeprg=pnpm\ --package=typescript\ dlx\ tsc\ --noEmit

setlocal fdm=manual

