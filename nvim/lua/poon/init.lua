vim.api.nvim_create_user_command('PoonAppend', function(opts)
  R('poon.lua.append').text(opts.args)
end, { 
  nargs = '?',
  complete = 'file'
})

return {
  setup = R("poon.lua.config"),
  toggle = R("poon.lua.toggle"),
  append = R("poon.lua.append"),
}
