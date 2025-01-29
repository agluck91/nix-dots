{pkgs, ...}: {
  home.packages = with pkgs; [
    cameractrls
  ];
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      obs-backgroundremoval
      obs-pipewire-audio-capture
      droidcam-obs
    ];
  };
}
