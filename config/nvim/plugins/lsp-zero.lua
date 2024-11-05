return {
    "VonHeikemen/lsp-zero.nvim",
    branch = 'v1.x',
    dependencies = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' },
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },
      { "onsails/lspkind-nvim" },

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lua' },
      {
          "L3MON4D3/LuaSnip",
          version = "v2.*",
          build = "make install_jsregexp",
          dependencies = {"rafamadriz/friendly-snippets"}, -- Snippets
          config = function()
              require("luasnip.loaders.from_vscode").lazy_load()
              -- https://github.com/rafamadriz/friendly-snippets/blob/main/snippets/go.json
          end
      },
      { 'rafamadriz/friendly-snippets' },
    },
    config = function()
      local lsp = require("lsp-zero")
      local luasnip = require("luasnip")
      local types = require("luasnip.util.types")

      luasnip.config.setup({
          ext_opts = {
              [types.choiceNode] = {
                  active = {virt_text = {{"⇥", "Red"}}}
              },
              [types.insertNode] = {
                  active = {virt_text = {{"⇥", "Blue"}}}
              }
          }
      })


      lsp.preset("recommended")

      lsp.ensure_installed({
        'dockerls',
        'html',
        'gopls',
        'jsonls',
        'vimls',
        'yamlls',
        'lua_ls',
        'remark_ls',
        'lemminx',
        'bashls'
      })

      -- Fix Undefined global 'vim':
      lsp.nvim_workspace()
      local cmp = require("cmp")
      local lspkind = require("lspkind")

      cmp.setup({
          snippet = {
              expand = function(args)
                  luasnip.lsp_expand(args.body)
              end
          },
          window = {
              completion = cmp.config.window.bordered(),
              documentation = cmp.config.window.bordered()
          },
          mapping = cmp.mapping.preset.insert({
              ["<C-b>"] = cmp.mapping.scroll_docs(-4),
              ["<C-f>"] = cmp.mapping.scroll_docs(4),
              ["<C-Space>"] = cmp.mapping.complete(),
              ["<C-e>"] = cmp.mapping.abort(),
              ["<CR>"] = cmp.mapping.confirm({select = true}),
              ["<Tab>"] = cmp.mapping(function(fallback)
                  if cmp.visible() then
                      cmp.select_next_item()
                  elseif luasnip.locally_jumpable(1) then
                      luasnip.jump(1)
                  else
                      fallback()
                  end
              end, {"i", "s"})
          }),
          sources = cmp.config.sources({
              {name = "nvim_lsp"}, {name = "luasnip"}, {name = "buffer"}
          }),
          formatting = {
              format = lspkind.cmp_format({
                  mode = "symbol_text",
                  maxwidth = 70,
                  show_labelDetails = true
              })
          }
      })


      lsp.on_attach(function(client, bufnr)
        local opts = {buffer = bufnr, remap = false}

        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
        vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
        vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
        vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
        vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
        vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
        vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
      end)

      lsp.setup()

      vim.diagnostic.config({
          virtual_text = true
      })
  end
}
