command! -nargs=+ Grep  execute 'silent grep! <args>' | copen | wincmd p | redraw!
command! -nargs=+ Grepadd execute 'silent grepa! <args>' | copen | wincmd p | redraw!
