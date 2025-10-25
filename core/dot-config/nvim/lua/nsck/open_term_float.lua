return function (cmd, opts)
  local buf = opts.buffer or vim.api.nvim_create_buf(not not opts.listed, true)
  local win = utils.open_float_buf(buf)

  if vim.fn.getbufvar(buf, "&buftype") == "terminal" then
    return win
  end

  return require('t/utils').create_term_buf(win, buf, cmd, opts)
end
