{
  lib,
  pkgs,
  ...
}: {
  programs.waybar = {
    enable = true;

    settings = let
      # catppuccin colors
      rosewater = "#f5e0dc";
      flamingo = "#f2cdcd";
      pink = "#f5c2e7";
      mauve = "#cba6f7";
      red = "#f38ba8";
      maroon = "#eba0ac";
      peach = "#fab387";
      yellow = "#f9e2af";
      green = "#a6e3a1";
      teal = "#94e2d5";
      sky = "#89dceb";
      sapphire = "#74c7ec";
      blue = "#89b4fa";
      lavender = "#b4befe";
      text = "#cdd6f4";
      subtext1 = "#bac2de";
      subtext0 = "#a6adc8";
      overlay2 = "#9399b2";
      overlay1 = "#7f849c";
      overlay0 = "#6c7086";
      surface2 = "#585b70";
      surface1 = "#45475a";
      surface0 = "#313244";
      base = "#1e1e2e";
      mantle = "#181825";
      crust = "#11111b";

      icon = size: color: icon: ''<span color="${color}" size="${size}">${icon} </span>'';
      iconButton = color: icon: ''<span color="${color}" size="large">${icon}</span>'';
      largeIcon = icon "large";
      iconLabel = color: icon: label: ''${largeIcon color icon} ${label}'';
    in {
      mainBar = {
        layer = "top";
        position = "bottom";
        spacing = 5;
        margin-left = 12;
        margin-right = 12;

        "custom/apps" = {
          format = iconLabel blue "󰀻" "Apps";
          on-click = "wofi --show drun --allow-images";
          tooltip-format = "App Launcher";
        };

        "custom/settings" = let
          settings = pkgs.gnome-control-center;
        in {
          format = iconButton blue "";
          on-click = "env XDG_CURRENT_DESKTOP=gnome ${settings}/bin/gnome-control-center";
          tooltip-format = "System Settings";
        };

        "custom/nautilus" = {
          format = iconButton blue "";
          on-click = "nemo";
          tooltip-format = "Open File Manager";
        };

        "custom/chrome" = {
          format = iconButton blue "";
          on-click = "google-chrome-stable";
          tooltip-format = "Google Chrome";
        };

        "custom/spotify" = {
          format = iconButton blue "";
          on-click = "spotify";
          tooltip-format = "Spotify";
        };

        "custom/discord" = {
          format = iconButton blue "";
          on-click = "vesktop";
          tooltip-format = "Discord";
        };

        "custom/sesh" = {
          format = iconButton blue " ";
          tooltip-format = "Open Kitty with Tmux Session Manager";
          on-click = "kitty sesh connect $(sesh list -t | wofi --dmenu)";
        };

        "custom/sshApple" = {
          format = iconButton blue "";
          tooltip-format = "Connect to MacBook Pro via SSH.";
          on-click = "kitty ssh mac";
        };

        "group/quick-links" = {
          orientation = "horizontal";
          modules = [
            "custom/settings"
            "custom/nautilus"
            "custom/discord"
            "custom/sshApple"
          ];
        };

        cpu = {
          format = iconLabel blue "" "{usage}%";
        };

        temperature = {
          format = iconLabel blue "" "{temperatureC}󰔄";
        };

        memory = {
          format = iconLabel blue "" "{used:0.1f}G/{total:0.1f}G";
        };
        battery = {
          format = iconButton blue "<span font='Font Awesome 5 Free 11'>{icon}</span>";
          format-icons = {
            default = ["󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
            charging = ["󰢟" "󰢜" "󰂆" "󰂇" "󰂈" "󰢝" "󰂉" "󰢞" "󰂊" "󰂋" "󰂅"];
          };
          format-time = "{H}h{M}m";
          format-charging = iconButton blue "<span font='Font Awesome 5 Free 11'>{icon}</span>";
          format-full = iconLabel blue "<span font='Font Awesome 5 Free 11'>{icon}</span>" "Full";
          format-warning = iconButton yellow "<span font='Font Awesome 5 Free 11'>{icon}</span>";
          format-critical = iconButton red "<span font='Font Awesome 5 Free 11'>{icon}</span>";
          format-omgosh = iconLabel red "" "Charge Now!";
          interval = 5;
          states = {
            warning = 25;
            critical = 15;
            omgosh = 10;
          };
          tooltip = true;
        };

        "group/stats" = {
          orientation = "horizontal";
          modules = [
            "cpu"
            "temperature"
            "memory"
            # "disk"
          ];
        };

        "custom/ssmonitor" = {
          format = iconButton blue "󰹑";
          tooltip-format = "Take screenshot of the entire monitor.";
          on-click = "hyprshot -m output";
        };

        "custom/sswindow" = {
          format = iconButton blue "";
          tooltip-format = "Take screenshot of a window.";
          on-click = "hyprshot -m window";
        };

        "custom/ssregion" = {
          format = iconButton blue "󰩭";
          tooltip-format = "Take screenshot of selected region.";
          on-click = "hyprshot -m region";
        };

        "group/screenshot" = {
          orientation = "horizontal";
          modules = [
            "custom/ssmonitor"
            "custom/sswindow"
            "custom/ssregion"
          ];
        };

        pulseaudio = {
          scroll-step = 2;
          on-click = "pavucontrol";
          on-click-right = "pamixer -t";
          format = iconLabel blue "{icon}" "{volume}%";
          format-bluetooth = iconLabel blue "{icon}" "{volume}";
          format-muted = largeIcon rosewater "";
          format-icons = {
            "alsa_output.pci-0000_00_1f.3.analog-stereo" = "";
            "alsa_output.pci-0000_00_1f.3.analog-stereo-muted" = "";
            headphone = "";
            headset = "󰋎";
            phone = "";
            phone-muted = "";
            portable = "";
            car = "";
            default = [
              ""
              ""
              ""
            ];
          };
        };

        network = {
          interval = 30;
          format-disconnected = iconLabel blue "󰖪" "0%";
          format-ethernet = iconLabel blue "" "{bandwidthTotalBits}";
          format-linked = "{ifname} (No IP)";
          format-wifi = iconLabel blue "" "{signalStrength}%";
          tooltip-format = "Connected to {essid} on {ifname}";
          on-click = "nm-connection-editor";
        };

        "clock#time" = {
          timezone = "EST";
          format = iconLabel blue "󰥔" "{:%I:%M %p}";
          on-click = "gnome-calendar";
          tooltip = false;
        };

        "clock#date" = {
          format = iconLabel blue "" "{:%A %b %d}";
          on-click = "gnome-calendar";
          tooltip = false;
        };

        "hyprland/window" = {
          format = iconLabel blue "󱄅" "{title}";
          rewrite = {
            "(.*) - Google Chrome" = "$1";
          };
        };

        "hyprland/workspaces" = {
          on-scroll-up = "hyprctl dispatch workspace r-1";
          on-scroll-down = "hyprctl dispatch workspace r+1";
          on-click = "activate";
          active-only = false;
          all-outputs = true;
          format = " {icon} ";
          format-icons = {
            "1" = " ";
            "2" = " ";
            "3" = " ";
            "4" = "󰍥 ";
            "5" = "󱄅 ";
          };

          persistent-workspaces = {
            "*" = [1 2 3 4 5];
          };
        };

        "custom/powermenu" = {
          format = iconButton blue "";
          tooltip-format = "Power menu";
          on-click = let
            logout = iconLabel text "" "Logout";
          in
            pkgs.writeShellScript "wofi-power-menu"
            #bash
            ''
              #!/bin/bash

              entries=" \tLogout \n  \tSuspend \n  \tReboot \n  \tShutdown \n \tLock"
              selected=$(echo -e $entries|wofi --width 250 --height 260 --hide_search=true --dmenu --cache-file /dev/null | awk '{print tolower($2)}')

              case $selected in
                logout)
                  exec hyprctl dispatch exit;;
                suspend)
                  exec systemctl suspend;;
                reboot)
                  exec systemctl reboot;;
                shutdown)
                  exec systemctl poweroff -i;;
                lock)
                  exec hyprlock;;
              esac
            '';
        };

        modules-left = [
          "group/quick-links"
        ];

        modules-center = [
          "clock#time"
          "clock#date"
          "pulseaudio"
          "hyprland/workspaces"
          "network"
          "group/stats"
        ];

        modules-right = [
          "group/screenshot"
          "battery"
          "custom/powermenu"
        ];
      };
    };

    style = ''
      ${lib.fileContents ../../config/waybar/catppuccin.css}
      ${lib.fileContents ../../config/waybar/styles.css}
    '';
  };

  stylix.targets.waybar.enable = false;
}
