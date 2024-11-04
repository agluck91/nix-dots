{pkgs, ...}: {
  home.packages = with pkgs; [
    slack
    vesktop
    google-chrome
    warp-terminal
    kooha
    chatgpt-cli
    todoist
    obsidian
    _1password-gui
    _1password-cli
    dbeaver-bin
    obs-studio
    xiphos
    postman
    remmina


    # terminal
    ripgrep
    bat
    gh
    bottom
    eza
    btop
    lazygit
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
