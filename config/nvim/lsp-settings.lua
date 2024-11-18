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

  local lspmap = vim.keymap.set

  lspmap("n", "<leader>lr", "<CMD>Telescope lsp_references<CR>", opts "References")
  lspmap("n", "<leader>li", "<CMD>Telescope lsp_implementations<CR>", opts "Implementation")
  lspmap("n", "<leader>lt", "<CMD>Telescope lsp_type_definitions<CR>", opts "Type definition")

  lspmap("n", "gD", vim.lsp.buf.declaration, opts "Go to declaration")
  lspmap("n", "gd", vim.lsp.buf.definition, opts "Go to definition")

  lspmap("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts "Workspace Symbols")
  lspmap("n", "<leader>vwa", vim.lsp.buf.add_workspace_folder, opts "Add workspace folder")
  lspmap("n", "<leader>vwr", vim.lsp.buf.remove_workspace_folder, opts "Remove workspace folder")
  lspmap("n", "<leader>vwl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, opts "List workspace folders")
  lspmap("n", "<leader>vd", vim.diagnostic.open_float, opts "Diagnostics")
  lspmap("n", "<leader>vca", vim.lsp.buf.code_action, opts "Code Actions")
  lspmap("n", "<leader>vr", vim.lsp.buf.references, opts "References")
  lspmap("n", "<leader>rn", vim.lsp.buf.rename, opts "Rename")
  lspmap("i", "<C-h>", vim.lsp.buf.signature_help, opts "Signature Help")
end
 
-- Used to enable autocompletion (assign to every lsp server config)
M.capabilities =
  vim.tbl_deep_extend("force", vim.lsp.protocol.make_client_capabilities(), cmp_nvim_lsp.default_capabilities())

return M
