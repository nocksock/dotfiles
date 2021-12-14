Plug 'alvan/vim-closetag'                                                       " Autoclose HTML Tags - with some smartness

let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.php'
let g:closetag_filetypes = 'html,xhtml,phtml,php'
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx,*.php'
let g:closetag_xhtml_filetypes = 'xhtml,jsx,php'

" integer value [0|1]
" This will make the list of non-closing tags case-sensitive (e.g. `<Link>` will be closed while `<link>` won't.)
let g:closetag_emptyTags_caseSensitive = 1

" dict
" Disables auto-close if not in a "valid" region (based on filetype)
let g:closetag_regions = {
    \ 'typescript.tsx': 'jsxRegion,tsxRegion',
    \ 'javascript.jsx': 'jsxRegion',
    \ 'typescriptreact': 'jsxRegion,tsxRegion',
    \ 'javascriptreact': 'jsxRegion',
    \ }
"
" Shortcut for closing tags, default is '>'
let g:closetag_shortcut = '>>'
