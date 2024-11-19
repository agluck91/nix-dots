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
    ansible
    typescript

    # terminal
    ripgrep
    gpclient
    dust
    dua
    bandwhich
    nushell
    hyperfine
    lm_sensors
    sshfs
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
