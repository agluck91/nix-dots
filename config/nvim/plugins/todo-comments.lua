require("todo-comments").setup({
	signs = true,
	keywords = {
		FIX = { icon = " ", color = "error" },
		TODO = { icon = " ", color = "info" },
		HACK = { icon = " ", color = "warning" },
		WARN = { icon = " ", color = "warning" },
		PERF = { icon = " ", color = "hint" },
		NOTE = { icon = " ", color = "hint" },
	},
	colors = {
		error = { fg = "error" },
		warning = { fg = "warning" },
		info = { fg = "info" },
		hint = { fg = "hint" },
	},
	search = {
		command = "rg",
		args = {
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
		},
		pattern = [[\b(KEYWORDS):]],
	},
})
