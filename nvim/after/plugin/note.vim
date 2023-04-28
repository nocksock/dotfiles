let g:note_root_dir="~/brain/HEAP/heap"

command! -nargs=1 -complete=customlist,NoteOpenCompletion Note call NoteOpen(<f-args>)
fun! NoteOpen(filename)
  let file = strftime("%Y%m%d%H%M") .. ".md"
  execute "tabnew " . g:note_root_dir . "/" . ( empty(a:filename) ? file : a:filename )
endfun

fun! NoteOpenCompletion(A,L,P)
    return split(substitute(glob(g:note_root_dir .. '/*'), expand(g:note_root_dir) .. '/', '', 'g'), "\n")
endfun

