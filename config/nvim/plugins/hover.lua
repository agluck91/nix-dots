require("hover").setup {
  init = function()
    require "hover.providers.lsp"
    require "hover.providers.diagnostic"
  end,
  preview_opts = {
    border = "single",
  },
  preview_window = false,
  title = true,
}
