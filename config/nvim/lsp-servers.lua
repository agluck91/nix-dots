local settings = require "lsp-settings"
local lspconfig = require "lspconfig"

--LSP configurations
local servers = {
  -- BASH
  bashls = {},
  -- HTML
  html = {},
  -- NIX
  nil_ls = {},
  -- LUA
  lua_ls = {
    settings = {
      Lua = {
        -- make the language server recognize "vim" global
        diagnostics = {
          globals = { "vim" },
        },
        completion = {
          callSnippet = "Replace",
        },
      },
    },
  },
  -- EMMET
  emmet_ls = {
    filetypes = {
      "html",
      "typescriptreact",
      "javascriptreact",
      "css",
      "sass",
      "scss",
      "less",
      "svelte",
    },
  },
  -- CSS
  cssls = {
    settings = {
      css = {
        lint = {
          unknownAtRules = "ignore",
        },
      },
    },
  },
  -- GRAPHQL
  graphql = {
    filetypes = {
      "graphql",
      "gql",
      "svelte",
      "javascript",
      "typescript",
      "typescriptreact",
      "javascriptreact",
    },
  },
  -- RELAY
  relay_lsp = {
    root_dir = lspconfig.util.root_pattern "relay.config.json",
  },
  -- DENO
  denols = {
    lint = true,
    root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
  },
  -- TYPESCRIPT
  ts_ls = {
    on_attach = function(client, bufnr)
      if lspconfig.util.root_pattern("deno.json", "deno.jsonc")(vim.fn.getcwd()) then
        if client.name == "tsserver" then
          client.stop()
          return
        end
      end

      return settings.on_attach(client, bufnr)
    end,
    single_file_support = false,
    root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", "node_modules"),
    init_options = {
      preferences = {
        disableSuggestions = true,
      },
    },
  },
  -- JSON schemas
  -- Schemas https://www.schemastore.org
  jsonls = {
    filetypes = { "json", "jsonc" },
    settings = {
      json = {
        schemas = {
          {
            fileMatch = { "deno.json" },
            url = "https://raw.githubusercontent.com/denoland/deno/main/cli/schemas/config-file.v1.json",
          },
          {
            fileMatch = { "package.json" },
            url = "https://json.schemastore.org/package.json",
          },
          {
            fileMatch = { "tsconfig*.json" },
            url = "https://json.schemastore.org/tsconfig.json",
          },
          {
            fileMatch = {
              ".prettierrc",
              ".prettierrc.json",
              "prettier.config.json",
            },
            url = "https://json.schemastore.org/prettierrc.json",
          },
          {
            fileMatch = {
              ".eslintrc",
              ".eslintrc.json",
              "eslint.config.json",
            },
            url = "https://json.schemastore.org/eslintrc.json",
          },
          {
            fileMatch = { ".babelrc", ".babelrc.json", "babel.config.json" },
            url = "https://json.schemastore.org/babelrc.json",
          },
          {
            fileMatch = { "lerna.json" },
            url = "https://json.schemastore.org/lerna.json",
          },
          {
            fileMatch = { "now.json", "vercel.json" },
            url = "https://json.schemastore.org/now.json",
          },
          {
            fileMatch = {
              ".stylelintrc",
              ".stylelintrc.json",
              "stylelint.config.json",
            },
            url = "http://json.schemastore.org/stylelintrc.json",
          },
        },
      },
    },
  },
  -- Ansible
  ansiblels = {},
  -- Docker
  dockerls = {},
  -- YAML
  yamlls = {},
  -- TOML
  tomls = {},
  -- Terraform
  terraformls = {},
  -- Markdown
  marksman = {},
  -- Rust
  rust_analyzer = {
    settings = {
      ["rust-analyzer"] = {
        checkOnSave = {
          command = "clippy",
        },
      },
    },
  },
  -- Go
  gopls = {
    settings = {
      gopls = {
        analyses = {
          unusedparams = true,
        },
        staticcheck = true,
      },
    },
  },
  -- TailwindCSS
  tailwindcss = {
    settings = {
      tailwindCSS = {
        classAttributes = {
          "class",
          "className",
          "class:list",
          "classList",
          "ngClass",
          "classNames",
          "styles",
        },
        experimental = {
          -- https://github.com/paolotiu/tailwind-intellisense-regex-list
          classRegex = {
            -- clsx
            { "clsx\\(([^]*)\\)", "(?:'|\"|`)([^\"'`]*)(?:'|\"|`)" },
            -- class-variance-authority
            { "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
            { "cx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
            -- Plain Javascript Object
            --  const styles = {
            --   wrapper: 'flex flex-col',
            --   navItem: 'relative mb-2 md:mb-0',
            --   bullet: 'absolute w-2 h-2 2xl:w-4 2xl:h-4 bg-red rounded-full',
            -- };
            { ":\\s*?[\"'`]([^\"'`]*).*?," },
            -- JavaScript string variable with keywords
            -- const styles = "bg-red-500 text-white";
            -- let Classes = "p-4 rounded";
            -- var classnames = "flex justify-center";
            -- const buttonStyles = "bg-blue-500 hover:bg-blue-700";
            -- let formClasses = "space-y-4";
            -- var inputClassnames = "border-2 border-gray-300";
            -- styles += 'rounded';
            {
              "(?:\\b(?:const|let|var)\\s+)?[\\w$_]*(?:[Ss]tyles|[Cc]lasses|[Cc]lassnames)[\\w\\d]*\\s*(?:=|\\+=)\\s*['\"]([^'\"]*)['\"]",
            },
            -- classList
            { "classList={{([^;]*)}}", "\\s*?[\"'`]([^\"'`]*).*?:" },
          },
        },
      },
    },
  },
}

for name, opts in pairs(servers) do
  if not opts.on_init then
    opts.on_init = settings.on_init
  end

  if not opts.capabilities then
    opts.capabilities = settings.capabilities
  end

  if not opts.on_attach then
    opts.on_attach = settings.on_attach
  end

  lspconfig[name].setup(opts)
end
