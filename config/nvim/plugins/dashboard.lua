local alpha = require "alpha"
local dashboard = require "alpha.themes.dashboard"

local function getGreeting()
  local tableTime = os.date "*t"
  local datetime = os.date " %A %b %m %Y  -   %I:%M %p"
  local hour = tableTime.hour
  local greetingsTable = {
    [1] = "  Sleep well",
    [2] = "  Good morning",
    [3] = "  Good afternoon",
    [4] = "  Good evening",
    [5] = "󰖔  Good night",
  }
  local greetingIndex = 0
  if hour == 23 or hour < 7 then
    greetingIndex = 1
  elseif hour < 12 then
    greetingIndex = 2
  elseif hour >= 12 and hour < 18 then
    greetingIndex = 3
  elseif hour >= 18 and hour < 21 then
    greetingIndex = 4
  elseif hour >= 21 then
    greetingIndex = 5
  end
  return datetime .. "  -  " .. greetingsTable[greetingIndex]
end

local logo = [[
        


                                              
       ████ ██████           █████      ██
      ███████████             █████ 
      █████████ ███████████████████ ███   ███████████
     █████████  ███    █████████████ █████ ██████████████
    █████████ ██████████ █████████ █████ █████ ████ █████
  ███████████ ███    ███ █████████ █████ █████ ████ █████
 ██████  █████████████████████ ████ █████ █████ ████ ██████

]]

dashboard.section.header.val = vim.split(logo, "\n")
dashboard.section.header.opts.hl = "DashboardFooter"

dashboard.section.buttons.opts.hl = "Keyword"
dashboard.section.buttons.val = {
  dashboard.button("n", "  New file", ":ene <BAR> startinsert <CR>"),
  dashboard.button("f", "  Find file", ":cd $HOME | silent Telescope find_files hidden=true no_ignore=true <CR>"),
  dashboard.button("s", "󰁯  Restore session", "<cmd>SessionRestore<CR>"),
  dashboard.button("t", "  Find text", ":Telescope live_grep <CR>"),
  dashboard.button("r", "󰄉  Recent files", ":Telescope oldfiles <CR>"),
  dashboard.button("d", "󱗼  Dotfiles", ":e $HOME/dotfiles <CR>"),
  dashboard.button("q", "󰿅  Quit", "<cmd>qa<CR>"),
}

dashboard.section.footer.val = vim.split("\n\n" .. getGreeting(), "\n")

-- vim.api.nvim_create_autocmd("User", {
--   pattern = "LazyVimStarted",
--   desc = "Add Alpha dashboard footer",
--   once = true,
--   callback = function()
--     pcall(vim.cmd.AlphaRedraw)
--   end,
-- })

dashboard.opts.opts.noautocmd = true
alpha.setup(dashboard.opts)
