vim.api.nvim_create_user_command('Diagnostics', function(args)
  local severity = args[1] == "error" and vim.diagnostic.severity.ERROR or  vim.diagnostic.severity.WARN
  if args.bang then
    vim.diagnostic.setloclist({ severity = severity, open = true })
  else
    vim.diagnostic.setqflist({ severity = severity, open = true })
  end
end, { bang = true, nargs = 0 })

