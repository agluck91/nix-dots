{pkgs, ...}: {
  home.packages = with pkgs; [
    slack
    vesktop
    dbeaver-bin
    pamixer
    google-chrome
    chromium
    kooha
    chatgpt-cli
    todoist
    todoist-electron
    teams-for-linux
    obsidian
    _1password-gui
    _1password-cli
    obs-studio
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
  ];
}
