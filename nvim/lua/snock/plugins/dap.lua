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

dap.adapters.node2 = {
  type = 'executable',
  command = 'node',
  args = { os.getenv('HOME') .. '/code/forks/vscode-node-debug2/out/src/nodeDebug.js' }
}

dap.adapters.chrome = {
  type = "executable",
  command = "node",
  args = { os.getenv("HOME") .. "/code/forks/vscode-chrome-debug/out/src/chromeDebug.js" }
}

local chrome_config = {
  type = "chrome",
  request = "attach",
  program = "${file}",
  cwd = vim.fn.getcwd(),
  sourceMaps = true,
  protocol = "inspector",
  port = 9229,
  webRoot = "${workspaceFolder}"
}

dap.configurations.javascript = {
  {
    name = 'Launch',
    type = 'node2',
    request = 'launch',
    program = '${file}',
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = 'inspector',
    console = 'integratedTerminal',
  },
  {
    name = 'Attach to process',
    type = 'node2',
    request = 'attach',
    processId = require 'dap.utils'.pick_process,
  },
}

dap.configurations.javascriptreact = {
  chrome_config
}

dap.configurations.typescriptreact = {
  chrome_config
}

dap.configurations.typescript = {
  chrome_config
}

