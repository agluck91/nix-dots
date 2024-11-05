-- import cmp-nvim-lsp plugin
local cmp_nvim_lsp = require "cmp_nvim_lsp"

  -- Set up nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- To use git you need to install the plugin petertriho/cmp-git and uncomment lines below
  -- Set configuration for specific filetype.
  --[[ cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'git' },
    }, {
      { name = 'buffer' },
    })
 })
 require("cmp_git").setup() ]]-- 

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    }),
    matching = { disallow_symbol_nonprefix_matching = false }
  })

  -- Set up lspconfig.
  local capabilities = require('cmp_nvim_lsp').default_capabilities()

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

  lspmap("n", "K", vim.lsp.buf.hover, opts "Hover")
  lspmap("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts "Workspace Symbols")
  lspmap("n", "<leader>vwa", vim.lsp.buf.add_workspace_folder, opts "Add workspace folder")
  lspmap("n", "<leader>vwr", vim.lsp.buf.remove_workspace_folder, opts "Remove workspace folder")
  lspmap("n", "<leader>vwl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, opts "List workspace folders")
  lspmap("n", "<leader>vd", vim.diagnostic.open_float, opts "Diagnostics")
  lspmap("n", "<leader>vca", vim.lsp.buf.code_action, opts "Code Actions")
  lspmap("n", "<leader>vr", vim.lsp.buf.references, opts "References")
  lspmap("n", "<leader>vrn", vim.lsp.buf.rename, opts "Rename")
  lspmap("i", "<C-h>", vim.lsp.buf.signature_help, opts "Signature Help")
end

-- Used to enable autocompletion (assign to every lsp server config)
M.capabilities =
  vim.tbl_deep_extend("force", vim.lsp.protocol.make_client_capabilities(), cmp_nvim_lsp.default_capabilities())

return M
