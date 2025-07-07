vim.api.nvim_create_user_command("Glow", function(opts)
  local cmd = "glow -w 80 -p "

  if opts.bang then
    if vim.bo.filetype == "markdown" then
      cmd = cmd .. vim.fn.expandcmd("%:p")
    else
      return print(":Glow! only works in markdown files")
    end
  end

  R('snock.utils').open_term_float(cmd, {})
end, { bang = true })
