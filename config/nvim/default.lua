vim.g.mapleader = " "

vim.keymap.set("n", "<leader>jk", "<cmd>Oil<CR>")
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Vim Navigation
vim.keymap.set("n", "<c-h>", ":wincmd h<CR>")
vim.keymap.set("n", "<c-j>", ":wincmd j<CR>")
vim.keymap.set("n", "<c-k>", ":wincmd k<CR>")
vim.keymap.set("n", "<c-l>", ":wincmd l<CR>")

--Tmux Navigation
vim.keymap.set("n", "<c-h>", ":TmuxNavigateLeft<cr>")
vim.keymap.set("n", "<c-j>", ":TmuxNavigateDown<cr>")
vim.keymap.set("n", "<c-k>", ":TmuxNavigateUp<cr>")
vim.keymap.set("n", "<c-l>", ":TmuxNavigateRight<cr>")
vim.keymap.set("n", "<c-\\>", ":TmuxNavigatePrevious<cr>")

-- Vim Test
vim.keymap.set('n', '<leader>tn', ':TestNearest<cr>')
vim.keymap.set('n', '<leader>tf', '<cmd>TestFile<cr>')
vim.keymap.set('n', '<leader>ts', '<cmd>TestSuite<cr>')
vim.keymap.set('n', '<leader>tl', '<cmd>TestLast<cr>')
vim.keymap.set('n', '<leader>tv', '<cmd>TestVisit<cr>')
vim.cmd('let test#strategy = "vimux"')

--Keymaps for config
vim.keymap.set("n", "<leader>ccp", "<cmd>e ~/.config/nvim/lua/setup/packer.lua<CR>");
vim.keymap.set("n", "<leader>ccr", "<cmd>e ~/.config/nvim/lua/setup/remap.lua<CR>");

--Useless Keymaps
vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>");

--Vim Config
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 10
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 50
vim.opt.filetype = "on"
vim.opt.encoding = "utf-8"
vim.opt.compatible = false
vim.opt.laststatus = 2
vim.opt.spell = true
vim.opt.spelllang = "en_us"
vim.opt.textwidth = 120
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamed"
vim.opt.scrollbind = false
vim.opt.wildmenu = true

-- filetype related
vim.api.nvim_create_autocmd("FileType", {
    pattern = {"gitcommit"},
    callback = function(ev)
        vim.api.nvim_set_option_value("textwidth", 72, {scope = "local"})
    end
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = {"markdown"},
    callback = function(ev)
        vim.api.nvim_set_option_value("textwidth", 0, {scope = "local"})
        vim.api.nvim_set_option_value("wrapmargin", 0, {scope = "local"})
        vim.api.nvim_set_option_value("linebreak", true, {scope = "local"})
    end
})
