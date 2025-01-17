{pkgs, ...}: {
  home.packages = [
    (pkgs.helpers.pyScript "hello")
  ];
}
