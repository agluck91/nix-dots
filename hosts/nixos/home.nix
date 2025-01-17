{...}: {
  imports = [
    ../../modules/home-manager/kitty.nix
    ../../modules/home-manager/git.nix
    ../../modules/home-manager/tmux.nix
    ../../modules/home-manager/zsh.nix
    ../../modules/home-manager/gnome.nix
    ../../modules/home-manager/dconf.nix
    ../../modules/home-manager/volta.nix
    ../../modules/home-manager/apps.nix
    ../../modules/home-manager/nix-apps.nix
    ../../modules/home-manager/nvim.nix
    ../../modules/home-manager/hyprland.nix
    ../../modules/home-manager/wofi.nix
    ../../modules/home-manager/hyprpanel.nix
    ../../modules/home-manager/fuzzle.nix
  ];

  home = {
    username = "agluck";
    homeDirectory = "/home/agluck";
    stateVersion = "24.05";
  };

  programs.home-manager.enable = true;
}
