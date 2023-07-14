vim9script

export def LspBindings()
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes

    nnoremap <buffer> <silent> gd :LspDefinition<CR>
    nnoremap <buffer> <silent> gR :LspRename<CR>
    nnoremap <buffer> <silent> ga :LspCodeAction --ui=float<CR>
    nnoremap <buffer> <silent> gdc :LspDeclaration<cr>
    nnoremap <buffer> <silent> gds :sp<cr>:LspDefinition<cr>
    nnoremap <buffer> <silent> gdv :vsp<cr>:LspDefinition<cr>
    nnoremap <buffer> <silent> gff :LspDocumentFormat<CR>
    nnoremap <buffer> <silent> gh :LspHover<CR>
    nnoremap <buffer> <silent> gi :LspImplementation<cr>
    nnoremap <buffer> <silent> gl :LspCodeLens<CR>
    nnoremap <buffer> <silent> gr :LspReferences<CR>
    nnoremap <buffer> <silent> grf :LspDocumentRangeFormat<CR>
    nnoremap <buffer> <silent> gs :LspWorkspaceSymbol<CR>
    nnoremap <buffer> <silent> gtd :LspTypeDefinition<CR>
    nnoremap <buffer> <silent> gth :LspTypeHierarchy<CR>
    nnoremap <buffer> <silent> <leader>xd :LspDocumentDiagnostics<cr>
    nnoremap <buffer> <silent> <leader>J :LspNextError<cr>
    nnoremap <buffer> <silent> <leader>K :LspPreviousError<cr>
    nnoremap <buffer> <buffer> K :LspPeekDefinition<cr>

    autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')
enddef
