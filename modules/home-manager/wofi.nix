{lib, ...}: {
  programs.wofi = {
    enable = true;
    settings = {
      width = 500;
      no_actions = true;
      allow_markup = true;
    };
    style = lib.fileContents ../../config/wofi/catppuccin.css;
  };

  stylix.targets.wofi.enable = false;
}
