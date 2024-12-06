local snacks = require("snacks")
snacks.setup({
	notifier = {
		enabled = true,
		timeout = 3000, -- default timeout in ms
		width = { min = 40, max = 0.4 },
		height = { min = 1, max = 0.6 },
		-- editor margin to keep free. tabline and statusline are taken into account automatically
		margin = { top = 0, right = 1, bottom = 0 },
		padding = true, -- add 1 cell of left/right padding to the notification window
		sort = { "level", "added" }, -- sort by level and time
		-- minimum log level to display. TRACE is the lowest
		-- all notifications are stored in history
		level = vim.log.levels.TRACE,
		icons = {
			error = " ",
			warn = " ",
			info = " ",
			debug = " ",
			trace = " ",
		},
		keep = function(notif)
			return vim.fn.getcmdpos() > 0
		end,
		style = "compact",
		top_down = true, -- place notifications from top to bottom
		date_format = "%R", -- time format for notifications
		more_format = " ↓ %d lines ",
		refresh = 50, -- refresh at most every 50ms
	},
})

local progress = vim.defaulttable()
vim.api.nvim_create_autocmd("LspProgress", {
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		local value = ev.data.params.value
		if not client or type(value) ~= "table" then
			return
		end
		local p = progress[client.id]

		for i = 1, #p + 1 do
			if i == #p + 1 or p[i].token == ev.data.params.token then
				p[i] = {
					token = ev.data.params.token,
					msg = ("[%3d%%] %s%s"):format(
						value.kind == "end" and 100 or value.percentage or 100,
						value.title or "",
						value.message and (" **%s**"):format(value.message) or ""
					),
					done = value.kind == "end",
				}
				break
			end
		end

		local msg = {} ---@type string[]
		progress[client.id] = vim.tbl_filter(function(v)
			return table.insert(msg, v.msg) or not v.done
		end, p)

		local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
		vim.notify(table.concat(msg, "\n"), "info", {
			id = "lsp_progress",
			title = client.name,
			opts = function(notif)
				notif.icon = #progress[client.id] == 0 and " "
					or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
			end,
		})
	end,
})
