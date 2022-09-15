--
--        ....
--    .xH888888Hx.
--  .W8888888888888.           u.
--  888*"""?""*88888X    ...ue888b
-- 'f     d8x.   ^%88k   888R Y888r
-- '>    <88888X   '?8   888R I888>
--  `:..:`888888>    8>  888R I888>
--         `"*88     X   888R I888>
--    .xHHhx.."      !  u8888cJ888
--   X88888888hx. ..!    "*888*P"
--  !   "*888888888"       'Y"
--         ^"***"`
--
--
-- A tiny task manager that helps you stay on track.
--
-- TODO: use custom hl groups
-- TODO: docs
local create = vim.api.nvim_create_user_command
local kaomoji = require("do.kaomojis")
local ui = R('do.ui')

---@class DoOptions
local default_opts = {
  use_winbar = true,
  message_timeout = 2000,

  ---@class TaskStoreOptions
  store = {
    auto_create_file = false,
    file_name = ".do_tasks",
  }
}

---@class DoState
---@field message? string
local state = {
  tasks = R('do.store'),
  message = nil,
  options = default_opts
}

local M = {}

function M.view()
  -- using pcall so that it won't spam error messages
  local ok, display = pcall(function()
    local count = state.tasks:count()
    local display = ""
    local aligned = false

    if state.message then
      return state.message
    end

    if count == 0 then
      return ""
    end

    display = "%#TablineSel# Doing: " .. state.tasks:current()

    if count > 1 then
      display = display .. "%=+" .. (count - 1 ) .. " more "
      aligned = true
    end

    if not state.tasks.state.file then
      display = display .. (aligned and "" or "%=") .."(:DoSave)"
    end

    return display
  end)

  if not ok then
    return "ERR: " .. display
  end

  return display
end

---Show a message for the duration of `options.message_timeout`
---@param str string Text to display
---@param hl? string Highlight group
function M.show_message(str, hl)
  state.message = "%#" .. (hl or "TablineSel") .. "#" .. str

  vim.defer_fn(function ()
    state.message = nil
  end, default_opts.message_timeout)
end

---@param str string
---@param to_front boolean
function M.add(str, to_front)
  state.tasks:add(str, to_front)
end

function M.done()
  if state.tasks:count() == 0 then
    M.show_message(kaomoji.confused() .. " There was nothing left to do…", "InfoMsg")
    return
  end

  local did = state.tasks:shift()

  if state.tasks:count() == 0 then
    M.show_message(kaomoji.joy() .. " did: " .. did .. ". ALL DONE! " .. kaomoji.joy(), "TablineSel")
  else
    M.show_message(kaomoji.joy() .. " did: " .. did .. ". Only " .. state.tasks:count() .. " to go.", "MoreMsg")
  end
end

function M.clear()
  state.tasks:clear()
  M.show_message(kaomoji.doubt() .. " Cleared all todos.", "WarningMsg")
end

M.toggle_float = function()
  ui.toggle_edit(state.tasks:get(), function(new_todos)
    state.tasks:set(new_todos)
  end)
end

M.save = function()
  state.tasks:save(true)
end

create("Do", function(args)
  M.add(args.args, args.bang)
end, { nargs = 1, bang = true })

create("Done", function(args)
  if not args.bang then
    M.show_message(kaomoji.doubt() .. " Really? If so, use Done!", "ErrorMsg")
    return
  end

  M.done()
end, { bang = true })

create("DoEdit", M.toggle_float, {})
create("DoClear", M.clear, { bang = true })
create("DoSave", M.save, { bang = true })

_G.DoStatusline = M.view

---@param opts DoOptions
M.setup = function(opts)
  state.options = vim.tbl_deep_extend("force", default_opts, opts or {})
  state.tasks = R("do.store").init(state.options.store)

  if state.options.use_winbar then
    vim.o.winbar = "%!v:lua.DoStatusline()"
  end
end

return M
