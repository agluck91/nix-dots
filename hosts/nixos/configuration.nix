{
  pkgs,
  config,
  inputs,
  lib,
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

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

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
      videoDrivers = ["nvidia" "modesetting"];
      displayManager.gdm.enable = true;
      displayManager.gdm.wayland = true;
      desktopManager.gnome = {
        enable = true;
        extraGSettingsOverridePackages = [pkgs.mutter];
        extraGSettingsOverrides = ''
          [org.gnome.mutter]
          experimental-features=['variable-refresh-rate', 'scale-monitor-framebuffer']
        '';
      };
    };
    printing = {
      enable = true;
      drivers = [pkgs.hplipWithPlugin];
    };
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
    openssh.enable = true;
    tailscale.enable = true;
    touchegg.enable = true;
  };

  security = {
    rtkit.enable = true;
  };

  systemd = {
    services = {
      nvidia-suspend.enable = false;
      nvidia-resume.enable = false;
      nvidia-hibernate.enable = false;
    };
  };

  nix.settings.experimental-features = ["nix-command" "flakes"];

  virtualisation.libvirtd.enable = true;
  virtualisation.docker.enable = true;

  programs = {
    dconf.enable = true;
    zsh.enable = true;
    firefox = {
      enable = true;
      package = pkgs.firefox;
      nativeMessagingHosts.packages = [pkgs.firefoxpwa];
    };
    virt-manager.enable = true;
    light.enable = true;
  };

  users = {
    defaultUserShell = pkgs.zsh;
    users.agluck = {
      isNormalUser = true;
      description = "agluck";
      extraGroups = ["networkmanager" "wheel" "audio" "video" "docker"];
    };
  };

  nixpkgs.config.allowUnfree = true;

  environment = {
    systemPackages = with pkgs; [
      vim
      wget
      git
      curl
      nil
      zip
      unzip
      cmake
      lm_sensors
      gnumake
      lshw
      firefoxpwa
      inputs.ghostty.packages.x86_64-linux.default
      inputs.alejandra.defaultPackage.${pkgs.system}
    ];
    pathsToLink = ["/share/zsh"];
    shells = with pkgs; [zsh];
    sessionVariables = {
      EDITOR = "nvim";
      TERMINAL = "kitty";
    };
    etc = {
      "resolv.conf".text = "nameserver 10.10.1.1\nnameserver 10.10.1.234\nnameserver 1.1.1.1\n";
    };
  };

  hardware.acpilight.enable = true;

  hardware.graphics = {
    enable = true;
  };

  hardware.nvidia = {
    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead
    # of just the bare essentials.
    powerManagement.enable = false;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of
    # supported GPUs is at:
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
    # Only available from driver 515.43.04+
    # Currently alpha-quality/buggy, so false is currently the recommended setting.
    open = false;

    # Enable the Nvidia settings menu,
    # accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.beta;
  };

  hardware.nvidia.prime = {
    sync.enable = true;
    # Make sure to use the correct Bus ID values for your system!
    nvidiaBusId = "PCI:1:0:0";
    amdgpuBusId = "PCI:6:0:0";
  };

  specialisation = {
    on-the-go.configuration = {
      system.nixos.tags = ["on-the-go"];
      hardware.nvidia = {
        prime.offload.enable = lib.mkForce true;
        prime.offload.enableOffloadCmd = lib.mkForce true;
        prime.sync.enable = lib.mkForce false;
      };
    };
  };

  system.stateVersion = "24.05";
}
