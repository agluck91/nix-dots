{...}: {
  imports = [
    ../../modules/home-manager/kitty.nix
    ../../modules/home-manager/tmux.nix
    ../../modules/home-manager/volta.nix
    ../../modules/home-manager/nvim.nix
  ];

  home.stateVersion = "24.05";
  programs.home-manager.enable = true;
}
