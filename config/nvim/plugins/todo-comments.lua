require("todo-comments").setup({
	-------------------------------------------
	-- FIX: Testing the todo-comments plugin
	-- FIXME: Testing the todo-comments plugin
	-- BUG: Testing the todo-comments plugin
	-- TODO: Testing the todo-comments plugin
	-- HACK: Testing the todo-comments plugin
	-- WIP: Testing the todo-comments plugin
	-- WARN: Testing the todo-comments plugin
	-- WARNING: Testing the todo-comments plugin
	-- PERF: Testing the todo-comments plugin
	-- OPTIM: Testing the todo-comments plugin
	-- PERFORMANCE: Testing the todo-comments plugin
	-- NOTE: Testing the todo-comments plugin
	-- INFO: Testing the todo-comments plugin
	-- TEST: Testing the todo-comments plugin
	-- TESTING: Testing the todo-comments plugin
	-- DEBUG: Testing the todo-comments plugin

	-------------------------------------------

	signs = true,
	sign_priority = 8,
	keywords = {
		FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
		TODO = { icon = " ", color = "info" },
		HACK = { icon = " ", color = "warning", alt = { "WIP" } },
		WARN = { icon = " ", color = "warning", alt = { "WARNING" } },
		PERF = { icon = " ", color = "error", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
		NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
		TEST = { icon = "⏲ ", color = "test", alt = { "TESTING" } },
		DEBUG = { icon = " ", color = "warning" },
	},
	colors = {
		error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
		warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
		info = { "DiagnosticInfo", "#2563EB" },
		hint = { "DiagnosticHint", "#10B981" },
		default = { "Identifier", "#7C3AED" },
		test = { "Identifier", "#FF00FF" },
	},
	merge_keywords = true,
	highlight = {
		multiline = true, -- enable multine todo comments
		multiline_pattern = "^.", -- lua pattern to match the next multiline from the start of the matched keyword
		multiline_context = 10, -- extra lines that will be re-evaluated when changing a line
		before = "", -- "fg" or "bg" or empty
		keyword = "wide", -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
		after = "fg", -- "fg" or "bg" or empty
		pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlighting (vim regex)
		comments_only = true, -- uses treesitter to match keywords in comments only
		max_line_len = 400, -- ignore lines longer than this
		exclude = {}, -- list of file types to exclude highlighting
	},
	search = {
		--
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
