local dap = require('dap')
local dapui = require('dapui')

-- DAPUI listeners
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open({})
end

dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close({})
end

dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close({})
end

dap.adapters.delve = {
  type = "server",
  host = "127.0.0.1",
  port = 38697,
}

-- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
dap.configurations.go = {
  {
    type = "delve",
    name = "Debug",
    request = "launch",
    program = "${file}"
  },
  {
    type = "delve",
    name = "Debug test",
    request = "launch",
    mode = "test",
    program = "${file}"
  },
  {
    type = "delve",
    name = "Debug test (with go.mod and sub packages)",
    request = "launch",
    mode = "test",
    program = "./${relativeFileDirname}"
  }
}

require('dap-go').setup()
require('dapui').setup {}
