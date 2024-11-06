{pkgs, ...}: {
  home.packages = with pkgs; [
    slack
    vesktop
    google-chrome
    kooha
    chatgpt-cli
    todoist
    obsidian
    _1password-gui
    _1password-cli
    obs-studio
    xiphos
    remmina
    popsicle
    trayscale

    #dev
    postgresql
    rustup
    docker
    nvidia-docker
    kubernetes-helm
    kubectl
    rancher
    minikube
    postman
    deno
    go
    dbeaver-bin
    poetry
    typescript


    # terminal
    ripgrep
    mosh
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
  ];
}
