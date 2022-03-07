command! LspDef lua vim.lsp.buf.definition()
command! LspFormatting lua vim.lsp.buf.formatting()
command! LspCodeAction lua vim.lsp.buf.code_action()
command! LspHover lua vim.lsp.buf.hover()
command! LspRename lua vim.lsp.buf.rename()
command! LspRefs lua vim.lsp.buf.references()
command! LspTypeDef lua vim.lsp.buf.type_definition()
command! LspImplementation lua vim.lsp.buf.implementation()
command! LspDiagPrev lua vim.diagnostic.goto_prev()
command! LspDiagNext lua vim.diagnostic.goto_next()
command! LspDiagLine lua vim.diagnostic.open_float()
command! LspSignatureHelp lua vim.lsp.buf.signature_help()

nmap K :LspHover<CR>
nnoremap <leader>id <Plug>:LspDiagLine
nmap gD :LspTypeDef<CR>
nmap gd :LspDef<CR>
nmap gr :LspRefs<CR>
nnoremap ga <cmd>Telescope lsp_code_actions theme=cursor<cr>
imap <c-x><c-x> <cmd>LspSignatureHelp<CR>
