local treesitter = require("nvim-treesitter.configs")

treesitter.setup({
    ensure_installed = {},
    indent = {enable = true},
    auto_install = false,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    textobjects = {select = {enable = true, lookahead = true}}
})
