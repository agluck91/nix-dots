{pkgs, ...}:{
  home.packages = [pkgs.warp-terminal];
  home.file.".local/share/warp-terminal/themes/catppuccin_mocha.yml".source = ../../config/warp-terminal/themes/catppuccin_mocha.yml;
}
