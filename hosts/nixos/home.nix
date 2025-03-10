{pkgs, ...}: {
  imports = [
    ../../modules/home-manager/kitty.nix
    ../../modules/home-manager/git.nix
    ../../modules/home-manager/tmux.nix
    ../../modules/home-manager/zsh.nix
    ../../modules/home-manager/gnome.nix
    ../../modules/home-manager/dconf.nix
    ../../modules/home-manager/volta.nix
    ../../modules/home-manager/apps.nix
    ../../modules/home-manager/nix-apps.nix
    ../../modules/home-manager/nvim.nix
    ../../modules/home-manager/hyprland.nix
    ../../modules/home-manager/wofi.nix
    ../../modules/home-manager/hyprpanel.nix
    ../../modules/home-manager/pro-video.nix
    ../../modules/home-manager/kubernetes.nix
  ];

  home = {
    username = "agluck";
    homeDirectory = "/home/agluck";
    stateVersion = "24.05";
    #User helper scripts
    packages = [
      (pkgs.helpers.pyScript "start-proxy")
      (pkgs.helpers.pyScript "kill-proxy")
      (pkgs.helpers.pyScript "savew")
      (pkgs.helpers.pyScript "restorew")
    ];
  };

  xdg.mimeApps = {
    enable = true;

    defaultApplications = {
      "text/html" = "google-chrome.desktop";
      "x-scheme-handler/http" = "google-chrome.desktop";
      "x-scheme-handler/https" = "google-chrome.desktop";
      "x-scheme-handler/about" = "google-chrome.desktop";
      "x-scheme-handler/unknown" = "google-chrome.desktop";
    };
  };

  programs.home-manager.enable = true;
}
