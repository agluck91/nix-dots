{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/nix-ld.nix
    ../../modules/nixos/timezone.nix
    ../../modules/nixos/pipewire.nix
    ../../modules/nixos/stylix.nix
    ../../modules/nixos/gaming.nix
    ../../modules/nixos/hyprland.nix
  ];

  boot.loader.grub = {
    enable = true;
    device = "/dev/vda";
    useOSProber = true;
  };

  networking = {
    hostName = "nix-dev";
    networkmanager.enable = true;
  };

  services = {
    flatpak.enable = true;
    xserver = {
      enable = true;
      xkb = {
        layout = "us";
        variant = "";
      };
      videoDrivers = ["modesetting"];
      displayManager.gdm.enable = true;
      desktopManager.gnome = {
        enable = true;
        extraGSettingsOverridePackages = [pkgs.mutter];
        extraGSettingsOverrides = ''
          [org.gnome.mutter]
          experimental-features=['variable-refresh-rate', 'scale-monitor-framebuffer']
        '';
      };
    };
    printing.enable = true;
    qemuGuest.enable = true;
    spice-vdagentd.enable = true;
    openssh.enable = true;
  };

  security.rtkit.enable = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];

  virtualisation.libvirtd.enable = true;

  programs = {
    dconf.enable = true;
    zsh.enable = true;
    firefox.enable = true;
    virt-manager.enable = true;
  };

  users = {
    defaultUserShell = pkgs.zsh;
    users.agluck = {
      isNormalUser = true;
      description = "agluck";
      extraGroups = ["networkmanager" "wheel" "audio"];
    };
  };

  nixpkgs.config.allowUnfree = true;

  environment = {
    systemPackages = with pkgs; [
      vim
      wget
      git
      curl
      spice-vdagent
      nil
      zip
      unzip
      cmake
      gnumake
      cargo
      inputs.alejandra.defaultPackage.${pkgs.system}
    ];
    pathsToLink = ["/share/zsh"];
    shells = with pkgs; [zsh];
  };

  system.stateVersion = "24.05";
}
