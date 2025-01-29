{pkgs, ...}: {
  home.packages = with pkgs; [
    keymapp
    slack
    ghostty
    barrier
    vesktop
    dbeaver-bin
    cider-2
    gimp
    google-chrome
    kooha
    x264
    todoist
    todoist-electron
    teams-for-linux
    obsidian
    _1password-gui
    audacity
    zoom-us
    popsicle
    nautilus
    localsend
    dconf2nix
    watchman
  ];
}
