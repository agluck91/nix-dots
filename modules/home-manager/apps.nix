{pkgs, ...}: {
  home.packages = with pkgs; [
    slack
    vesktop
    pamixer
    google-chrome
    chromium
    kooha
    chatgpt-cli
    todoist
    todoist-electron
    teams-for-linux
    obsidian
    _1password-gui
    _1password-cli
    obs-studio
    xiphos
    zoom-us
    remmina
    popsicle
    trayscale
    lm_sensors
    nemo-with-extensions
    nautilus
    localsend

    #dev
    postgresql
    rustup
    libpqxx
    libgcc
    nvidia-docker
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
    dbeaver-bin
    poetry
    typescript


    # terminal
    ripgrep
    awscli2
    sesh
    gum
    mosh
    unimatrix
    asciiquarium-transparent
    pipes
    bat
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
