{
  pkgs,
  lib,
  ...
}: {
  xdg.enable = lib.mkDefault true;

  gtk = {
    enable = true;
    iconTheme = lib.mkForce {
      name = "Papirus-Dark";
      package = pkgs.catppuccin-papirus-folders.override {
        flavor = "mocha";
        accent = "blue";
      };
    };
  };

  home.packages = with pkgs; [
    dconf-editor
    gnome-tweaks
  ];
}
