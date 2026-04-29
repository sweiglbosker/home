local dap = require("dap")
local ui = require("dapui")

ui.setup()

local map = vim.keymap.set

local function nmap(lhs, rhs, opts)
	map("n", lhs, rhs, opts)
end

nmap("<leader>b", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
nmap("<leader>B", dap.run_to_cursor, { desc = "Run to cursor" })
nmap("<leader>dso", dap.step_over, { desc = "Step Over" })
nmap("<leader>dsi", dap.step_into, { desc = "Step Into" })
nmap("<leader>df", dap.step_out, { desc = "Step Out" })
nmap("<leader>dr", dap.restart, { desc = "Restart DAP session" })
nmap("<leader>dd", ui.toggle, { desc = "Toggle DAP ui"})
nmap("<leader>dc", dap.continue, { desc = "Continue (DAP)"})

vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DapBreakpoint" })
vim.fn.sign_define("DapLogPoint", { text = "", texthl = "DapBreakpoint" })
vim.fn.sign_define("DapStopped", { text = "", texthl = "DapStopped" })
vim.fn.sign_define("DapBreakpointCondition", { text = "", texthl = "DapBreakpoint" })
vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "DapBreakpoint" })

dap.listeners.before.attach.dapui_config = function()
	ui.open()
end
dap.listeners.before.launch.dapui_config = function()
	ui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
	-- ui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
	-- ui.close()
end

dap.adapters.gdb = {
	type = "executable",
	command = "gdb",
	args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
}

dap.configurations.c = {
	{
		name = "Launch",
		type = "gdb",
		request = "launch",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		args = {}, -- provide arguments if needed
		cwd = "${workspaceFolder}",
		stopAtBeginningOfMainSubprogram = false,
	},
	{
		name = "Select and attach to process",
		type = "gdb",
		request = "attach",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		pid = function()
			local name = vim.fn.input("Executable name (filter): ")
			return require("dap.utils").pick_process({ filter = name })
		end,
		cwd = "${workspaceFolder}",
	},
	{
		name = "Attach to gdbserver :1234",
		type = "gdb",
		request = "attach",
		target = "localhost:1234",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		cwd = "${workspaceFolder}",
	},
}

dap.configurations.scala = {
	{
		type = "scala",
		request = "launch",
		name = "Run or Test Target",
		metals = {
			runType = "runOrTestFile",
		},
	},
	{
		type = "scala",
		request = "launch",
		name = "Test Target",
		metals = {
			runType = "testTarget",
		},
	},
	{
		type = "scala",
		request = "attach",
		name = "Attach to Localhost",
		hostName = "localhost",
		port = 5005,
		buildTarget = "root",
	},
}
dap.configurations.cpp = dap.configurations.c
