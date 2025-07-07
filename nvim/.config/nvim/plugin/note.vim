let g:note_root_dir="~/brain/HEAP/heap"

command! -nargs=1 -complete=customlist,NoteOpenCompletion Note call NoteOpen(<f-args>)
fun! NoteOpen(filename)
  let file = strftime("%Y%m%d%H%M") .. ".md"
  execute "tabnew " . g:note_root_dir . "/" . ( empty(a:filename) ? file : a:filename )
endfun

function! NoteOpenCompletion(A,L,P)
    return split(substitute(glob(g:note_root_dir .. '/*'), expand(g:note_root_dir) .. '/', '', 'g'), "\n")
endfunction

command! No NoteFind
command! -nargs=* NoteFind call NoteFind(<q-args>)
fun! NoteFind(query = "")
  let command ="rg --column --line-number --no-heading --color=always --smart-case -- "

  let opts = {
        \ 'source': ':',
        \ 'dir': g:note_root_dir,
        \ 'options': ['--ansi', '--prompt', ' Find Note > ', '--query', a:query,
        \             '--disabled',
        \             '--bind', 'start:reload:'.command.' '.shellescape(a:query),
        \             '--bind', 'change:reload:'.command.' {q} || :',
        \             '--multi', '--bind', 'alt-a:select-all,alt-d:deselect-all',
        \ '--bind', 'ctrl-r:reload(:)',
        \             '--bind', 'ctrl-n:execute-silent(touch '.g:note_root_dir.'/{q}.md) | reload)',
        \             '--delimiter', ':', '--preview', 'bat ' . g:note_root_dir . '/{1}', '--preview-window', '+{2}-/2'],
        \ 'down': '40%',
        \ }

  fun! opts.sink(p)
    let filename = split(a:p, ':')[0]
    execute('tabedit ' . g:note_root_dir . '/' . filename)
  endfun

  return fzf#run(fzf#wrap(opts))
endfun
