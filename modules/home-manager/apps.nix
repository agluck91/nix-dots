{pkgs, ...}: {
  home.packages = with pkgs; [
    slack
    vesktop
    google-chrome
    warp-terminal
    kooha
    tailscale
    chatgpt-cli
    todoist
    todoist-electron
    obsidian
    _1password-gui
    _1password
    calibre
    dbeaver-bin
    obs-studio
    xiphos
    zoom-us
    postman
    remmina


    # terminal
    ripgrep
    bat
    bottom
    eza
    btop
    lazygit
    oh-my-posh
    neofetch
    python3
    cmatrix
    nurl
    eza

    # fonts
    fira-code-nerdfont

    # utils
    dconf2nix
    watchman

    # dev
    deno
  ];
}
