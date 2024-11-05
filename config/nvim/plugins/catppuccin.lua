vim.opt.termguicolors = true

require("catppuccin").setup({
    flavour = "mocha",
    term_colors = true,
    styles = {
        conditionals = {},
        functions = {"italic"},
        types = {"bold"}
    },
    highlight_overrides = {
      mocha = function(C)
        return {
          NvimTreeNormal = {bg = C.none},
          CmpBorder = {fg = C.surface2}, 
          Pmenu = {bg = C.none},
          NormalFloat = {bg = C.none},
          TelescopeBorder = {link = "FloatBorder"},
      }
      end
    },
    integrations = {
        barbar = true,
        cmp = true,
        gitsigns = true,
        native_lsp = {enabled = true},
        nvimtree = true,
        telescope = true,
        treesitter = true,
        treesitter_context = true,
        indent_blankline = {
            enabled = true,
            scope_color = "blue",
            colored_indent_levels = true,
        }
    }
})

vim.cmd.colorscheme("catppuccin")
