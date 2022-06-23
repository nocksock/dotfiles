local dap = require('dap')
local dapui = require('dapui')

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
	icons = { expanded = '▾', collapsed = '▸' },
	mappings = {
		-- Use a table to apply multiple mappings
		expand = { '<CR>', '<2-LeftMouse>' },
		open = 'o',
		remove = 'd',
		edit = 'e',
		repl = 'r',
		toggle = 't',
	},
	floating = {
		max_height = nil, -- These can be integers or a float between 0 and 1.
		max_width = nil, -- Floats will be treated as percentage of your screen.
		border = 'single', -- Border style. Can be "single", "double" or "rounded"
		mappings = {
			close = { 'q', '<Esc>' },
		},
	},
	windows = { indent = 1 },
	layouts = {
		{
			elements = {
				'scopes',
				'breakpoints',
				'stacks',
				'watches',
			},
			size = 40,
			position = 'left',
		},
		{
			elements = {
				'repl',
				'console',
			},
			size = 10,
			position = 'bottom',
		},
	},
})

dap.listeners.after.event_initialized['dapui_config'] = function()
	dapui.open()
end
dap.listeners.before.event_terminated['dapui_config'] = function()
	dapui.close()
end
dap.listeners.before.event_exited['dapui_config'] = function()
	dapui.close()
end
