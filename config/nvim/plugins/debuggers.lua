local dap, dapui = require("dap"), require("dapui")

dapui.setup()

-- Setup debuggers
require("dap-go").setup()

-- Automatically open and close the DAP UI
dap.listeners.before.attach.dapui_config = function()
	dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
	dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
	dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
	dapui.close()
end

-- Keybindings
vim.keymap.set("n", "<F6>", function()
	require("dap").continue()
end)
vim.keymap.set("n", "<F7>", function()
	require("dap").step_over()
end)
vim.keymap.set("n", "<F8>", function()
	require("dap").step_into()
end)
vim.keymap.set("n", "<F9>", function()
	require("dap").step_out()
end)
vim.keymap.set("n", "<Leader>db", function()
	require("dap").toggle_breakpoint()
end)
vim.keymap.set("n", "<Leader>dl", function()
	require("dap").run_last()
end)
