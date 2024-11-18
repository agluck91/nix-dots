{pkgs, ...}: {
  home.packages = with pkgs; [
    #dev
    postgresql
    rustup
    libpqxx
    libgcc
    kubernetes-helm
    kubectl
    k9s
    lazydocker
    rancher
    minikube
    postman
    chatblade
    deno
    go
    poetry
    pulumi-bin
    opentofu
    typescript

    # terminal
    ripgrep
    lm_sensors
    sshfs
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
    eza

    # fonts
    fira-code-nerdfont
    nerdfonts
  ];
}
