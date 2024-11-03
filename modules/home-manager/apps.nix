{pkgs, ...}: {
  home.packages = with pkgs; [
    slack
    vesktop
    google-chrome
    warp-terminal
    kooha

    # terminal
    ripgrep
    bat
    eza
    yazi
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
