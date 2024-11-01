{
  pkgs,
  lib,
  ...
}: let
  settings = {
    tmux = lib.fileContents ../../config/tmux/tmux.conf;
    catppuccin = lib.fileContents ../../config/tmux/tmux.catppuccin.conf;
  };
in {

  programs.tmux = {
    enable = true;
    keyMode = "vi";
    prefix = "C-s";
    mouse = true;
    terminal = "screen-256color";
    baseIndex = 1;
    extraConfig = settings.tmux;

    plugins = with pkgs; [
      tmuxPlugins.vim-tmux-navigator
      tmuxPlugins.yank
      {
        plugin = tmuxPlugins.catppuccin;
        extraConfig = settings.catppuccin;
      }
    ];
  };
}
