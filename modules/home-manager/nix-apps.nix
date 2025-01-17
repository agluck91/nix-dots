{pkgs, ...}: {
  home.packages = with pkgs; [
    keymapp
    slack
    ghostty
    vesktop
    dbeaver-bin
    cider-2
    google-chrome
    kooha
    x264
    todoist
    todoist-electron
    teams-for-linux
    obsidian
    _1password-gui
    obs-studio
    obs-studio-plugins.obs-backgroundremoval
    audacity
    zoom-us
    popsicle
    nautilus
    localsend
    dconf2nix
    watchman
  ];
}
