local telescope = require("telescope")
local actions = require("telescope.actions")

telescope.setup({
    defaults = {
        sorting_strategy = "ascending",
        prompt_prefix = "   ",
        layout_strategy = "horizontal",
        layout_config = {prompt_position = "top"},
        mappings = {
            i = {
                ["<C-k>"] = actions.move_selection_previous, -- move to prev result
                ["<C-j>"] = actions.move_selection_next, -- move to next result
                ["<C-q>"] = actions.send_selected_to_qflist +
                    actions.open_qflist -- send selected to quickfixlist
            }
        }
    },
    extensions = {
        fzf = {
          fuzzy = true, -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true, -- override the file sorter
          case_mode = "smart_case", -- or "ignore_case" or "respect_case"
        },
    }
})

telescope.load_extension("fzf")

local builtin = require("telescope.builtin")

-- key maps

local opts = {noremap = true, silent = true}

vim.keymap.set("n", "<leader>fb", ":Telescope file_browser<CR>")
vim.keymap.set("n", "<leader>ff", builtin.find_files, opts) -- Lists files in your current working directory, respects .git ignore
vim.keymap.set("n", "<leader>fx", builtin.treesitter, opts) -- Lists tree-sitter symbols
vim.keymap.set("n", "<leader>fs", builtin.spell_suggest, opts) -- Lists spell options
