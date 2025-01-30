# Custom packages overlay
final: prev: {
  customPackages = prev.callPackage (import ../pkgs) {};
}
