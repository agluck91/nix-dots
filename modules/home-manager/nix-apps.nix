{pkgs, ...}: {
  home.packages = with pkgs; [
    slack
    vesktop
    dbeaver-bin
    pamixer
    google-chrome
    chromium
    kooha
    x264
    chatgpt-cli
    todoist
    todoist-electron
    teams-for-linux
    obsidian
    _1password-gui
    _1password-cli
    obs-studio
    obs-studio-plugins.obs-backgroundremoval
    openshot-qt
    ardour
    audacity
    xiphos
    zoom-us
    remmina
    popsicle
    trayscale
    nemo-with-extensions
    nautilus
    localsend
    dconf2nix
    watchman
    screenkey
  ];
}