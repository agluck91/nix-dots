require("lsp-file-operations").setup()

local x = vim.diagnostic.severity

-- Sets global diagnostic config
vim.diagnostic.config {
  virtual_text = { prefix = "" },
  -- Change the Diagnostic symbols in the sign column (gutter)
  signs = { text = { [x.ERROR] = "󰅙 ", [x.WARN] = " ", [x.INFO] = " ", [x.HINT] = "󰠠 " } },
  underline = true,
  float = { border = "single" },
}

require "lsp-servers"
