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
    act
    postman
    chatblade
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
    bandwhich
    nushell
    hyperfine
    cheat
    speedtest-cli
    awscli2
    sesh
    gum
    mosh
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
    fira-code-nerdfont
    nerdfonts
  ];
}
