{pkgs, ...}: let
  firaSans = {
    package = pkgs.fira-sans;
    name = "Fira Sans";
  };
  firaCode = {
    package = pkgs.nerd-fonts.fira-code;
    name = "FiraCode Nerd Font";
  };
in {
  stylix = {
    enable = true;
    autoEnable = true;
    image = ../../config/wallpapers/a0ez44uhhx911.jpg;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    polarity = "dark";

    cursor = {
      package = pkgs.banana-cursor-dreams;
      size = 96;
      name = "Banana-Catppuccin-Mocha";
    };

    fonts = {
      serif = firaSans;
      sansSerif = firaSans;
      monospace = firaCode;
      emoji = firaCode;
    };

    targets.grub.enable = true;
    targets.grub.useImage = true;
  };
}
