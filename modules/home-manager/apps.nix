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
    lm_sensors

    #dev
    postgresql
    rustup
    nvidia-docker
    kubernetes-helm
    kubectl
    rancher
    minikube
    postman
    chatblade
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
    tealdeer
    btop
    lazygit
    neofetch
    python3
    cmatrix
    nurl
    eza

    # fonts
    fira-code-nerdfont
    nerdfonts

    # utils
    dconf2nix
    watchman
  ];
}
