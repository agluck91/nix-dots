-- import cmp-nvim-lsp plugin
local cmp_nvim_lsp = require "cmp_nvim_lsp"

local M = {}

-- Disable semanticTokens
M.on_init = function(client, _)
  if client.supports_method "textDocument/semanticTokens" then
    client.server_capabilities.semanticTokensProvider = nil
  end
end

-- Callback invoked when attaching a buffer to a language server.
M.on_attach = function(__client, bufnr)
  local function opts(desc)
    return { buffer = bufnr, silent = true, desc = "LSP - " .. desc }
  end

  local map = vim.keymap.set

  map("n", "<leader>lr", "<CMD>Telescope lsp_references<CR>", opts "References")
  map("n", "gd", "<CMD>Telescope lsp_definitions<CR>", opts "Definition")
  map("n", "<leader>li", "<CMD>Telescope lsp_implementations<CR>", opts "Implementation")
  map("n", "<leader>lt", "<CMD>Telescope lsp_type_definitions<CR>", opts "Type definition")

  -- map("n", "gD", vim.lsp.buf.declaration, opts "Go to declaration")
  -- map("n", "gd", vim.lsp.buf.definition, opts "Go to definition")

  map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts "Code Actions")

  map("n", "<leader>rn", vim.lsp.buf.rename, opts "Smart Rename")

  map("n", "<leader>d", "<CMD>Telescope diagnostics bufnr=0<CR>", opts "Show buffer diagnostics")
  map("n", "<leader>D", "<CMD>Telescope diagnostics bufnr=nill<CR>", opts "Show buffer diagnostics (all buffers)")
  -- map("n", "<leader>D", vim.diagnostic.open_float, opts "Show line diagnostics")
  map("n", "[d", vim.diagnostic.goto_prev, opts "Go to previous diagnostic")
  map("n", "]d", vim.diagnostic.goto_next, opts "Go to next diagnostic")

  -- TODO: do I really need these?
  map("n", "<leader>sh", vim.lsp.buf.signature_help, opts "Show signature help")

  map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts "Add workspace folder")
  map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts "Remove workspace folder")
  map("n", "<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, opts "List workspace folders")
end

-- Used to enable autocompletion (assign to every lsp server config)
M.capabilities =
  vim.tbl_deep_extend("force", vim.lsp.protocol.make_client_capabilities(), cmp_nvim_lsp.default_capabilities())

return M
