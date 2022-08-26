-- :T
--  mini version of (floa|toggle|neo)term.
--
-- :T to toggle a floating terminal - without closing the buffer.
--
-- Accepts a count to open another Term, if needed:
--  :2T, toggles Term number 2
--
-- TODO: set buffer name with index and cmd
-- TODO: hide numbers in splits
-- TODO: :{count}T! {cmd} remove buffer
-- TODO: :{count}T {cmd}

local utils = R("snock.utils")
local default = utils.default
local opts = { count = true, nargs = "?", bang = true }

---return all terminal type buffers
---@return List
local function get_terms() -- {{{
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

local function attach_mappings(ctx) --{{{
  if ctx.buffer == nil then
    print("buffer unknown in attach_mappings")
    return
  end

  vim.keymap.set('n', "<ESC>", "<cmd>close<CR>", { buffer = ctx.buffer })
end --}}}

local function create_command_cb(fn) --{{{
  return function(cmd_ctx)
    local term_buf = get_term_by_idx(cmd_ctx.count == 0 and 1 or cmd_ctx.count)
    local visible, handle = utils.is_visible(term_buf)
    local command = default(cmd_ctx.args, "zsh")

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
    on_enter = attach_mappings,
  })
end), opts) --}}}
vim.api.nvim_create_user_command("Ts", create_command_cb(function(term_buf, ctx) --{{{
  utils.open_term_split(ctx.command, {
    buffer = term_buf,
    on_enter = attach_mappings,
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

-- vim: fen fdm=marker fdl=0
