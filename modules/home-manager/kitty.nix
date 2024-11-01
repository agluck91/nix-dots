{pkgs, ...}: {
  home.packages = [pkgs.kitty];

  programs.kitty = {
    enable = true;
    shellIntegration.enableZshIntegration = true;

    settings = {
      enable_audio_bell = false;
      close_on_child_death = true;
      bold_font = "FiraCode Nerd Font Bold";
      italic_font = "FiraCode Nerd Font Italic";
      bold_italic_font = "FiraCode Nerd Font Bold Italic";

      window_padding_width = 4;
      wayland_titlebar_color = "background";
      enabled_layouts = "fat, tall, vertical";

      dynamic_background_opacity = true;
    };
  };
}
