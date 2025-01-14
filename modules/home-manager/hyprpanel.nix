{inputs, ...}: {
  imports = [inputs.hyprpanel.homeManagerModules.hyprpanel];

  programs.hyprpanel = {
    enable = true;
    systemd.enable = true;
    overwrite.enable = true;

    theme = "catppuccin_mocha";

    layout = {
      "bar.layouts" = {
        "*" = {
          left = ["dashboard" "media" "windowtitle"];
          middle = ["workspaces"];
          right = ["volume" "network" "bluetooth" "clock" "notifications" "power"];
        };
      };
    };

    settings = {
      bar.launcher.autoDetectIcon = true;
      bar.workspaces.show_icons = true;
      bar.notifications.show_total = true;
      bar.notifications.hideCountWhenZero = true;
      bar.workspaces.showWsIcons = true;
      bar.workspaces.workspaceIconMap = ''
        {
          "1": " ",
          "2": " ",
          "3":  " ",
          "4":  "󰙯 ",
          "5":  "󱄅 ",
        }
      '';

      menus.clock = {
        time = {
          military = false;
          hideSeconds = true;
        };
        weather.unit = "metric";
      };

      menus.dashboard.directories.enabled = false;
      menus.dashboard.stats.enable_gpu = true;

      theme.bar.transparent = true;
      theme.bar.location = "bottom";
      theme.bar.buttons.enableBorders = true;
      theme.bar.buttons.borderSize = "0.02em";
      theme.bar.buttons.radius = "1em";

      notifications.position = "bottom";

      theme.font = {
        name = "Fira Code Nerd Font";
        size = "16px";
      };
    };
  };
}
