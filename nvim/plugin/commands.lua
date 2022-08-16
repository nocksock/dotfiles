if pcall(require, 'plenary') then
  RELOAD = require('plenary.reload').reload_module

  R = function(name)
    RELOAD(name)
    return require(name)
  end
end

P = function(v)
  print(vim.inspect(v))
  return v
end

local create = vim.api.nvim_create_user_command

-- TODO: convert to lua
vim.cmd([[
  " :E to edit/create file relative to the current buffer
  command! -nargs=1 -complete=customlist,EditRelativeComplete E edit %:h/<args>
  fun! EditRelativeComplete(A,L,P)
        return split(substitute(glob(expand('%:h') .. '/*'), expand('%:h') .. '/', '', 'g'), "\n")
  endfun
]])

create("EditSnippet", function()
  require('luasnip.loaders.from_lua').edit_snippet_files()
end, {})

create("BG", function()
  vim.o.background = vim.o.background == "light" and "dark" or "light"
end, {})

create("Glow", function(opts)
  local cmd = "glow -w 80 -p "

  if opts.bang then
    if vim.bo.filetype == "markdown" then
      cmd = cmd .. vim.fn.expandcmd("%:p")
    else
      return print(":Glow! only works in markdown files")
    end
  end

  R('snock.utils').open_float_term(cmd, {})
end, { bang = true })

create("LazyGit", function()
  R('snock.utils').open_float_term("lazygit", {})
end, { nargs = "?" })

