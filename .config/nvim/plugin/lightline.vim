let g:lightline = {
      \   'active': {
      \     'left': [ [ 'mode', 'paste' ],
      \               [ 'gitbranch', ], ['readonly', 'path', 'modified']],
      \     'right': [['filetype', 'percent', 'lineinfo']],
      \   },
      \   'component': {
      \     'path': '%<%f',
      \   },
      \   'component_function': {
      \     'gitbranch': 'gitbranch#name',
      \   },
      \   'mode_map': {
      \     'n' : 'N',
      \     'i' : 'I',
      \     'R' : 'R',
      \     'v' : 'v',
      \     'V' : 'V',
      \     "\<C-v>": 'B',
      \     'c' : 'C',
      \     's' : 's',
      \     'S' : 'S',
      \     "\<C-s>": 'S',
      \     't': '$'
      \   }
      \ }
let g:lightline.subseparator = { 'left': '', 'right': '' }

" reload lightline entirely - useful when changing its configuration
command! LightLineReload
      \ call lightline#init()
      \ call lightline#colorscheme()
      \ call lightline#update()
