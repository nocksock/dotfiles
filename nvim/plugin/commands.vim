" :E to edit/create file relative to the current buffer
command! -nargs=1 -complete=customlist,EditRelativeComplete E edit %:h/<args>
fun! EditRelativeComplete(A,L,P)
      return split(substitute(glob(expand('%:h') .. '/*'), expand('%:h') .. '/', '', 'g'), "\n")
endfun

command! LuaSnipEdit :lua require("luasnip.loaders.from_lua").edit_snippet_files()
