{
  pkgs,
  config,
  ...
}: {
  home.packages = [pkgs.volta];

  home.sessionVariables = {
    VOLTA_HOME = "${config.home.homeDirectory}/.volta";
  };
}
