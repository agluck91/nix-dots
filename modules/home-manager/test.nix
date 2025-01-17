{pkgs, ...}: {
  home.packages = [
    (pkgs.helpers.pyScript "tmux-os-icon")
  ];
}
