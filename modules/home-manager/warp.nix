{pkgs-stable, ...}:{
  home.packages = [pkgs-stable.warp-terminal];
  home.file.".local/share/warp-terminal/themes/catppuccin_mocha.yml".source = ../../config/warp/catppuccin_mocha.yml;
}
