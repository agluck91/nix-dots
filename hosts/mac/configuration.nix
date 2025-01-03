{pkgs, ...}: let
  username = "agluck";
in {
  # Used for backwards compatibility.
  system.stateVersion = 5;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
  nixpkgs.config.allowUnfree = true;

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  nix = {
    package = pkgs.nix;
    # Enable the Flakes feature and the accompanying new nix command-line tool
    settings. experimental-features = ["nix-command" "flakes"];

    # optimise store
    optimise.automatic = true;

    # Enable automatic garbage collection
    gc = {
      automatic = true;
      options = "--delete-older-than 30d";
    };
  };

  users.users = {
    ${username} = {
      name = username;
      home = "/Users/${username}";
    };
  };

  programs.zsh.enable = true;
  environment.pathsToLink = ["/share/zsh"];
  environment.shells = with pkgs; [zsh];
  programs.bash.enable = false;
  environment.variables = {
    LANG = "en_US.UTF-8";
    LC_ALL = "en_US.UTF-8";
    locale = "en_US.UTF-8";
    XDG_CONFIG_PATH = "/home/${username}/.config/";
    TERM = "xterm-256color";
  };
}
