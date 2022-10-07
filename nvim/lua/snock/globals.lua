_G.snock = {}

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

function snock.maybe_call(f, ...)
  if f then
    f(...)
  end
end

function snock.cycle(values, value) --{{{
  local next_val_idx = ((snock.index_of(values, value)) % #values) + 1
  return values[next_val_idx]
end --}}}
function snock.default(val, default)--{{{
  if val == "" or val == nil then
    return default
  end

  return val
end--}}}
function snock.index_of(tbl, value) --{{{
  for idx, tval in ipairs(tbl) do
    if value == tval then
      return idx
    end
  end
end --}}}
function snock.is_visible(bufnr) --{{{
  local wins = vim.api.nvim_tabpage_list_wins(0)
  for _, handle in ipairs(wins) do
    if vim.api.nvim_win_get_buf(handle) == bufnr then
      return true, handle
    end
  end
  return false, nil
end --}}}
function snock.invert(fn) --{{{
  return function(...)
    return not fn(...)
  end
end --}}}

-- buffer helper:

function snock.open_float_buf(bufnr) --{{{
  local padding = {
    x = 8,
    y = 4,
  }
  local max_width = vim.opt.columns:get()
  local max_height = vim.opt.lines:get()

  local win = vim.api.nvim_open_win(bufnr, true, {
    relative = "win",
    style = "minimal",
    border = "double",
    noautocmd = true,
    col = padding.x,
    row = padding.y,
    width = max_width - (2 * padding.x),
    height = max_height - (2 * padding.y),
  })

  vim.cmd("startinsert")

  return {
    buffer = bufnr,
    window = win
  }
end --}}}
function snock.create_term_buf(win, buf, cmd, opts) --{{{
  if opts == nil then opts = {} end

  local function on_exit()
    if opts.on_exit then opts.on_exit(buf) end
    vim.api.nvim_buf_delete(buf, { force = true })
  end

  vim.api.nvim_set_current_buf(buf)

  local ch  = vim.fn.termopen(cmd, { on_exit = on_exit }) -- nvim_open_term cannot set cmd
  local ctx = { window = win, buffer = buf }

  if opts.on_enter then opts.on_enter(ctx, ch) end

  return ctx
end --}}}

-- term helper:

function snock.open_term_split(cmd, opts) --{{{
  local buf = opts.buffer or vim.api.nvim_create_buf(true, true)

  vim.cmd(opts.type or "split")

  local win = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_buf(win, buf)

  if vim.fn.getbufvar(buf, "&buftype") == "terminal" then
    return win
  end

  return snock.create_term_buf(win, buf, cmd, opts)
end --}}}
function snock.open_term_float(cmd, opts) --{{{
  local buf = opts.buffer or vim.api.nvim_create_buf(not not opts.listed, true)
  local win = snock.open_float_buf(buf)

  if vim.fn.getbufvar(buf, "&buftype") == "terminal" then
    return win
  end

  return snock.create_term_buf(win, buf, cmd, opts)
end --}}}

-- vim: fen fdm=marker fdl=0
