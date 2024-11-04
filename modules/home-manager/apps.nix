{pkgs, ...}: {
  home.packages = with pkgs; [
    slack
    vesktop
    google-chrome
    warp-terminal
    kooha
    tailscale

    # terminal
    ripgrep
    bat
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
