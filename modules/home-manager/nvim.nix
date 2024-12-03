{
  lib,
  pkgs,
  inputs,
  ...
}: {
  home.packages = [pkgs.lazygit];

  xdg.enable = lib.mkDefault true;
  xdg.configFile."nvim/lua/lsp-servers.lua".source = ../../config/nvim/lsp-servers.lua;
  xdg.configFile."nvim/lua/lsp-settings.lua".source = ../../config/nvim/lsp-settings.lua;
  xdg.configFile."nvim/lua/default.lua".source = ../../config/nvim/default.lua;

  programs.neovim = {
    enable = true;
    package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraLuaConfig = ''
      require "default";
    '';

    extraPackages = with pkgs; [
      # # Tools --
      xclip
      wl-clipboard

      # # LSP --
      nil
      gopls
      lua-language-server
      typescript-language-server
      vscode-langservers-extracted # html, css, json and eslint
      tailwindcss-language-server
      nodePackages.graphql-language-service-cli
      emmet-language-server
      emmet-ls
      dockerfile-language-server-nodejs
      yaml-language-server
      bash-language-server
      ansible-language-server
      nginx-language-server
      helm-ls
      marksman
      terraform-ls
      sqls
      rust-analyzer
      hyprls

      # # Formatters --
      prettierd
      stylua
      isort
      black
      shfmt
      alejandra
      rustfmt

      # # Linters --
      pylint
      pyright
      eslint_d
      codespell
      golint
    ];

    plugins = let
      toLuaType = builtins.map (plugin: plugin // {type = "lua";});

      plain = with pkgs.vimPlugins; [
        # Utils
        plenary-nvim
        dressing-nvim
        hologram-nvim
        nvim-web-devicons
        vim-tmux-navigator
        nui-nvim
        vimux
        vim-illuminate
        glow-nvim
        gitsigns-nvim
        nvim-comment
        nvim-autopairs
        nvim-web-devicons
        nvim-notify
        nvim-surround
        todo-comments-nvim
        vim-test
        git-conflict-nvim

        # CMP
        cmp-path
        cmp-buffer
        cmp-nvim-lsp
        luasnip
        cmp_luasnip
        friendly-snippets
        lspkind-nvim
        lualine-lsp-progress

        # Treesitter
        nvim-ts-context-commentstring
        nvim-ts-autotag
        nvim-treesitter-textobjects

        which-key-nvim
        lazygit-nvim
        nvim-surround
        telescope-fzf-native-nvim
      ];

      withConfig = with pkgs.vimPlugins; [
        {
          plugin = alpha-nvim;
          config = lib.fileContents ../../config/nvim/plugins/dashboard.lua;
        }
        {
          plugin = none-ls-nvim;
          config = lib.fileContents ../../config/nvim/plugins/none-ls.lua;
        }
        {
          plugin = catppuccin-nvim;
          config = lib.fileContents ../../config/nvim/plugins/catppuccin.lua;
        }
        {
          plugin = copilot-lua;
          config = lib.fileContents ../../config/nvim/plugins/copilot.lua;
        }
        {
          plugin = render-markdown-nvim;
          config = lib.fileContents ../../config/nvim/plugins/render-markdown.lua;
        }
        {
          plugin = img-clip-nvim;
          config = lib.fileContents ../../config/nvim/plugins/img-clip.lua;
        }
        {
          plugin = avante-nvim;
          config = lib.fileContents ../../config/nvim/plugins/avante.lua;
        }
        {
          plugin = nvim-cmp;
          config = lib.fileContents ../../config/nvim/plugins/cmp.lua;
        }
        {
          plugin = cloak-nvim;
          config = lib.fileContents ../../config/nvim/plugins/cloak.lua;
        }
        {
          plugin = nvim-autopairs;
          config = lib.fileContents ../../config/nvim/plugins/auto-pairs.lua;
        }
        {
          plugin = auto-session;
          config = lib.fileContents ../../config/nvim/plugins/auto-session.lua;
        }
        {
          plugin = conform-nvim;
          config = lib.fileContents ../../config/nvim/plugins/conform.lua;
        }
        {
          plugin = hover-nvim;
          config = lib.fileContents ../../config/nvim/plugins/hover.lua;
        }
        {
          plugin = lualine-nvim;
          config = lib.fileContents ../../config/nvim/plugins/lualine.lua;
        }
        {
          plugin = noice-nvim;
          config = lib.fileContents ../../config/nvim/plugins/noice.lua;
        }
        {
          plugin = oil-nvim;
          config = lib.fileContents ../../config/nvim/plugins/oil.lua;
        }
        {
          plugin = telescope-nvim;
          config = lib.fileContents ../../config/nvim/plugins/telescope.lua;
        }
        {
          plugin = telescope-nvim;
          config = lib.fileContents ../../config/nvim/plugins/telescope.lua;
        }
        {
          plugin = indent-blankline-nvim;
          config = lib.fileContents ../../config/nvim/plugins/indent-blankline.lua;
        }
        {
          plugin = nvim-lspconfig;
          config = lib.fileContents ../../config/nvim/plugins/lspconfig.lua;
        }
        {
          plugin = nvim-treesitter.withPlugins (p: [
            p.tree-sitter-nix
            p.tree-sitter-vim
            p.tree-sitter-bash
            p.tree-sitter-lua
            p.tree-sitter-python
            p.tree-sitter-json
            p.tree-sitter-javascript
            p.tree-sitter-typescript
            p.tree-sitter-vue
            p.tree-sitter-tsx
            p.tree-sitter-yaml
            p.tree-sitter-html
            p.tree-sitter-go
            p.tree-sitter-gomod
            p.tree-sitter-gowork
            p.tree-sitter-csv
            p.tree-sitter-css
            p.tree-sitter-markdown
            p.tree-sitter-markdown-inline
            p.tree-sitter-svelte
            p.tree-sitter-graphql
            p.tree-sitter-dockerfile
            p.tree-sitter-sql
            p.tree-sitter-gitignore
            p.tree-sitter-query
            p.tree-sitter-vimdoc
            p.tree-sitter-mermaid
            p.tree-sitter-c
            p.tree-sitter-make
            p.tree-sitter-rust
            p.tree-sitter-toml
            p.tree-sitter-nginx
            p.tree-sitter-hcl
            p.tree-sitter-cmake
            p.tree-sitter-hyprlang
          ]);
          config = lib.fileContents ../../config/nvim/plugins/treesitter.lua;
        }
      ];
    in
      plain
      ++ (toLuaType withConfig);
  };
}
