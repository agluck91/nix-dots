{pkgs, ...}: {
  home.packages = with pkgs; [
    #dev
    postgresql
    rustup
    kubernetes-helm
    kubectl
    k9s
    lazydocker
    rancher
    minikube
    postman
    deno
    go
    delve
    poetry
    pulumi-bin
    opentofu
    ansible
    typescript

    # terminal
    ripgrep
    dust
    nushell
    hyperfine
    cheat
    speedtest-cli
    awscli2
    sesh
    gum
    mosh
    fabric-ai
    unimatrix
    asciiquarium-transparent
    pipes
    bat
    fd
    gh
    github-copilot-cli
    bottom
    jq
    yq
    eza
    tealdeer
    btop
    lazygit
    neofetch
    python3
    nurl

    # fonts
    nerd-fonts.fira-code
    nerd-fonts.hack
  ];
}
