cnoremap <expr> %%  getcmdtype() == ':' ? expand('%:h').'/' : '%%' " type %% in vim's prompt to insert %:h expanded
