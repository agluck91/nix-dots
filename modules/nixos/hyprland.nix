{pkgs, ...}: {
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  services.blueman.enable = true;

  programs.ssh.startAgent = true;

  programs.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    xwayland.enable = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
  };

  environment.systemPackages = with pkgs; [
    hyprdim
    hyprshot
    hyprpicker
    hyprcursor
    wl-clipboard
    libnotify
    pavucontrol
    networkmanagerapplet
    gnome-system-monitor
    gnome-calculator
    gnome-control-center
    gnome-weather
    gnome-clocks
    xdg-desktop-portal
    xdg-desktop-portal-hyprland
  ];

  # Optional, hint Electron apps to use Wayland:
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    WLR_NO_HARDWARE_CURSORS = "1";
  };
}
