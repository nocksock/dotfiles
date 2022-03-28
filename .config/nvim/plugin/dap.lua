local dap = require('dap')
local dapui = require("dapui")

dap.adapters.chrome = {
	type = 'executable',
	command = 'node',
	args = { os.getenv('HOME') .. '/forks/vscode-chrome-debug/out/src/chromeDebug.js' }, -- TODO adjust
}

dap.configurations.javascriptreact = { -- change this to javascript if needed
	{
		type = 'chrome',
		request = 'attach',
		program = '${file}',
		cwd = vim.fn.getcwd(),
		sourceMaps = true,
		protocol = 'inspector',
		port = 9222,
		webRoot = '${workspaceFolder}',
	},
}

dap.configurations.typescriptreact = { -- change to typescript if needed
	{
		type = 'chrome',
		request = 'attach',
		program = '${file}',
		cwd = vim.fn.getcwd(),
		sourceMaps = true,
		protocol = 'inspector',
		port = 9222,
		webRoot = '${workspaceFolder}',
	},
}

dap.adapters.firefox = {
	type = 'executable',
	command = 'node',
	args = { os.getenv('HOME') .. '/forks/vscode-firefox-debug/dist/adapter.bundle.js' },
}

dap.configurations.typescriptff = {
	name = 'Debug with Firefox',
	type = 'firefox',
	request = 'launch',
	reAttach = true,
	url = 'http://localhost:3000',
	webRoot = '${workspaceFolder}',
	firefoxExecutable = '/usr/bin/firefox',
}

dapui.setup({
  icons = { expanded = "▾", collapsed = "▸" },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
    toggle = "t",
  },
  sidebar = {
    -- You can change the order of elements in the sidebar
    elements = {
      -- Provide as ID strings or tables with "id" and "size" keys
      {
        id = "scopes",
        size = 0.25, -- Can be float or integer > 1
      },
      { id = "breakpoints", size = 0.25 },
      { id = "stacks", size = 0.25 },
      { id = "watches", size = 00.25 },
    },
    size = 40,
    position = "left", -- Can be "left", "right", "top", "bottom"
  },
  tray = {
    elements = { "repl" },
    size = 10,
    position = "bottom", -- Can be "left", "right", "top", "bottom"
  },
  floating = {
    max_height = nil, -- These can be integers or a float between 0 and 1.
    max_width = nil, -- Floats will be treated as percentage of your screen.
    border = "single", -- Border style. Can be "single", "double" or "rounded"
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  windows = { indent = 1 },
})

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end
