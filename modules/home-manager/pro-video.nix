{pkgs, ...}: {
  home.packages = with pkgs; [
    cameractrls-gtk4
  ];
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      obs-backgroundremoval
      obs-pipewire-audio-capture
    ];
  };
}
