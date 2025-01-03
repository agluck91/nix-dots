{
  pkgs,
  lib,
  ...
}: {
  xdg.enable = lib.mkDefault true;

  gtk = {
    enable = true;
    iconTheme = lib.mkForce {
      name = "Papirus-Dark";
      package = pkgs.catppuccin-papirus-folders.override {
        flavor = "mocha";
        accent = "blue";
      };
    };
  };

  home.packages = with pkgs; [
    dconf-editor
    gnome-tweaks
    caffeine-ng
    gnomeExtensions.freon
    gnomeExtensions.x11-gestures
    gnomeExtensions.tiling-shell
    gnomeExtensions.system-monitor
    gnomeExtensions.workspace-indicator
    gnomeExtensions.auto-move-windows
    gnomeExtensions.caffeine
    gnomeExtensions.bluetooth-quick-connect
    gnomeExtensions.clipboard-indicator
    gnomeExtensions.sound-output-device-chooser
    gnomeExtensions.systemd-manager
    gnomeExtensions.tailscale-status
  ];
}
