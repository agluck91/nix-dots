{pkgs, ...}: {
  home.packages = with pkgs; [
    #dev
    postgresql
    kubernetes-helm
    kubectl
    k9s
    lazydocker
    minikube
    postman
    go
    delve
    ansible
    typescript

    # terminal
    ripgrep
    dust
    dig
    speedtest-cli
    awscli2
    sesh
    gum
    mosh
    fabric-ai
    cava
    unimatrix
    asciiquarium-transparent
    pipes
    bat
    fd
    gh
    github-copilot-cli
    gcalcli
    bottom
    jq
    eza
    tealdeer
    btop
    lazygit
    neofetch
    python3

    # fonts
    nerd-fonts.fira-code
    nerd-fonts.hack
  ];
}
