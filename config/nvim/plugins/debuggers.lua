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
vim.keymap.set("n", "<f6>", dap.continue(), {})
vim.keymap.set("n", "<F7>", dap.step_over(), {})
vim.keymap.set("n", "<F8>", dap.step_into(), {})
vim.keymap.set("n", "<F9>", dap.step_out(), {})
vim.keymap.set("n", "<Leader>b", dap.toggle_breakpoint(), {})
vim.keymap.set("n", "<Leader>dr", dap.repl.open(), {})
vim.keymap.set("n", "<Leader>dl", dap.run_last(), {})
vim.keymap.set({ "n", "v" }, "<Leader>dh", require("dap.ui.widgets").hover(), {})
vim.keymap.set({ "n", "v" }, "<Leader>dp", require("dap.ui.widgets").preview(), {})
vim.keymap.set("n", "<Leader>df", function()
	local widgets = require("dap.ui.widgets")
	widgets.centered_float(widgets.frames)
end)
vim.keymap.set("n", "<Leader>ds", function()
	local widgets = require("dap.ui.widgets")
	widgets.centered_float(widgets.scopes)
end)
