-- :T
--  mini version of (floa|toggle|neo)term.
--
-- :T to toggle a floating terminal - without closing the buffer.
--
-- Accepts a count to open another Term, if needed:
--  :2T, toggles Term number 2
--
-- todo: set buffer name with index and cmd
-- todo: hide numbers in splits
-- todo: :{count}T! {cmd} remove buffer
-- todo: :{count}T {cmd}

local utils = R("snock.utils")
local opts = { count = true, nargs = "?", bang = true }
local augroup = vim.api.nvim_create_augroup('Tgroup', { clear = true })

vim.api.nvim_create_autocmd('TermOpen', { --{{{
  callback = function()
    local win = vim.api.nvim_get_current_win()

    if win ~= nil then return end

    vim.keymap.set('n', '<C-c>', 'i<C-c>', { buffer = true })
  end,
  group = augroup
}) --}}}

local function get_terms() --{{{
  return vim.tbl_filter(function(buf)
    return vim.fn.getbufvar(buf, "&buftype") == "terminal"
  end, vim.api.nvim_list_bufs());
end --}}}
local function get_term_by_bufnr(bufnr) --{{{
  for idx, value in ipairs(get_terms()) do
    if value == bufnr then
      return idx
    end
  end
end --}}}
local function get_term_by_idx(idx) --{{{
  local terms = get_terms()
  return terms[idx]
end --}}}

local function attach_behaviour(ctx) --{{{
  if not ctx.buffer then
    print("buffer unknown in attach_behaviour")
    P(ctx)
    return
  end

  vim.keymap.set('n', "<ESC>", "<cmd>close<CR>", { buffer = ctx.buffer })
end --}}}

local function create_command_cb(fn) --{{{
  return function(cmd_ctx)
    local term_buf = get_term_by_idx(cmd_ctx.count == 0 and 1 or cmd_ctx.count)
    local visible, handle = utils.is_visible(term_buf)
    local command = cmd_ctx.args == "" and "zsh" or cmd_ctx.args

    if visible then
      return vim.api.nvim_win_close(handle, true)
    end

    if cmd_ctx.bang and term_buf then
      return print("! to be done")
    end

    return fn(term_buf, vim.tbl_extend("keep", cmd_ctx, {
      command = command
    }))
  end
end --}}}

vim.api.nvim_create_user_command("T", create_command_cb(function(term_buf, ctx) --{{{
  utils.open_term_float(ctx.command, {
    listed = true,
    buffer = term_buf,
    on_enter = attach_behaviour,
  })
end), opts) --}}}
vim.api.nvim_create_user_command("Ts", create_command_cb(function(term_buf, ctx) --{{{
  utils.open_term_split(ctx.command, {
    buffer = term_buf,
    on_enter = attach_behaviour,
  })
end), opts) --}}}
vim.api.nvim_create_user_command("Tls", function() --{{{
  vim.ui.select(get_terms(), {
    prompt = "Select Terminal Buffer",
    format_item = function(item)
      return vim.api.nvim_buf_get_name(item)
    end
  }, function(choice)
    if choice then
      vim.cmd(get_term_by_bufnr(choice) .. 'T')
    end
  end)
end, {}) --}}}

-- vim:fdm=marker fdl=0
