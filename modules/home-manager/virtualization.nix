{pkgs, ...}: {
  virtualisation = {
    containers = {
      enable = true;
    };

    podman = {
      enable = true;
      dockerCompat = false; #alias podman to docker
      defaultNetwork.settings.dns_enabled = true;
    };

    docker = {
      enable = true;
    };

    libvirtd = {
      enable = true;
    };
  };

  programs = {
    virt-manager = {
      enable = true;
    };
  };

  home.packages = with pkgs; [
    dive # look into docker image layers
    podman-tui # status of containers in the terminal
    podman-compose # start group of containers for dev
  ];
}
