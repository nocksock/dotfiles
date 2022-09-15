---@class TaskStore
---@field state TaskStoreState
---@field options TaskStoreOptions
local M = {}

---@class TaskStoreState
---@field tasks string[]
local default_state = {
  options = {},
  file = nil,
  ---@alias Tasks string[]
  tasks = {}
}

---comment
---@param options TaskStoreOptions
local function get_file(options)
  local f = vim.fn.findfile(options.file_name, ".;")
  return f
end

local function read_file(file)
  local is_readable = vim.fn.filereadable(file) == 1
  assert(is_readable, string.format("file not %s readable", file))
  return vim.fn.readfile(file)
end

---@param options any
local function create_file(options)
  local f = io.open(options.file_name, "w")
  assert(f, "couldn't create " .. options.file_name)
  f:write("")
  f:close()
  return get_file(options)
end

function M:save(force)
  if not self.state.file and force then
    self.state.file = create_file(self.state.file)
    assert(self.state.file, "file not set despite saving")
  end

  if not self.state.file then
    print("not saving")
    return
  end

  if vim.fn.filewritable(self.state.file) then
    vim.fn.writefile(self.state.tasks, self.state.file)
  else
    error(string.format("Cannot write file %s", self.state.file))
  end

  return self
end

function M:current()
  return self.state.tasks[1]
end

function M:get()
  return self.state.tasks
end

---@param tasks Tasks
function M:set(tasks)
  self.state.tasks = tasks
  self:save()
end

function M:count()
  return #self:get()
end

function M:add(str, to_front)
  if to_front then
    table.insert(self.state.tasks, 1, str)
  else
    table.insert(self.state.tasks, str)
  end
  self:save()
  return self
end

function M:shift()
  local head = table.remove(self.state.tasks, 1)
  self:save()
  return head
end

---initialize task store
---@return TaskStore
M.init = function(options)
  local file = get_file(options)

  ---@type TaskStoreState
  local state = {
    file = file,
    options = options,
    tasks = file and read_file(file) or {}
  }

  local o = {
    state = vim.tbl_deep_extend("keep", state, default_state),
  }

  return setmetatable(o, { __index = M })
end

return M
