{inputs, ...}: {
  nixpkgs.overlays = [
    inputs.hyprpanel.overlay

    (import ./helpers.nix)
  ];
}
