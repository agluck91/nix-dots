{
  pkgs,
  lib,
  ...
}: let
  mapScriptsToPackages = lib.attrsets.mapAttrsToList (pkgs.writeShellScriptBin);
in {
  home.packages = mapScriptsToPackages {
    uptime-tmux =
      # sh
      ''
        uptime |
        	awk -F, '{print $1,$2}' |
        	sed 's/:/h /g;s/^.*up *//; s/ *[0-9]* user.*//;s/[0-9]$/&m/;s/ day. */d /g'
      '';
    git-tmux =
      # sh
      ''
        if [ -d .git ]; then
        	git fetch
        	branch=$(git rev-parse --abbrev-ref HEAD)
        	ahead=$(git rev-list --count origin/"$branch".."$branch")
        	behind=$(git rev-list --count "$branch"..origin/"$branch")
        	echo "$branch $ahead $behind"
        else
        	echo "N/A"
        fi
      '';
  };

  programs.tmux = {
    enable = true;
    keyMode = "vi";
    prefix = "C-s";
    mouse = true;
    terminal = "xterm-256color";
    baseIndex = 1;
    extraConfig = lib.fileContents ../../config/tmux/tmux.conf;

    plugins = with pkgs; [
      tmuxPlugins.vim-tmux-navigator
      tmuxPlugins.yank
      {
        plugin = tmuxPlugins.catppuccin;
        extraConfig = lib.fileContents ../../config/tmux/tmux.catppuccin.conf;
      }
      {
        plugin = tmuxPlugins.resurrect;
        extraConfig =
          # sh
          ''
            set -g @resurrect-strategy-nvim 'session'
          '';
      }
      {
        plugin = tmuxPlugins.continuum;
        extraConfig =
          # sh
          ''
            set -g @continuum-save-interval '5'
          '';
      }
    ];
  };
}
