{
  inputs,
  lib,
  ...
}: {
  imports = [
    ../../modules/home-manager/kitty.nix
    ../../modules/home-manager/git.nix
    ../../modules/home-manager/tmux.nix
    ../../modules/home-manager/zsh.nix
    ../../modules/home-manager/gnome.nix
    ../../modules/home-manager/dconf.nix
    ../../modules/home-manager/volta.nix
    ../../modules/home-manager/spotify.nix
    ../../modules/home-manager/apps.nix
  ];

  home.username = "agluck";
  home.homeDirectory = "/home/agluck";
  home.stateVersion = "24.05";
  programs.home-manager.enable = true;
}
