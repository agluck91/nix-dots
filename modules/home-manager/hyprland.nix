{
  inputs,
  pkgs,
  ...
}: {
  xdg.desktopEntries."org.gnome.Settings" = {
    name = "Settings";
    comment = "Gnome Control Center";
    icon = "org.gnome.Settings";
    exec = "env XDG_CURRENT_DESKTOP=gnome ${pkgs.gnome-control-center}/bin/gnome-control-center";
    categories = ["X-Preferences"];
    terminal = false;
  };

  programs.mpv.enable = true;

  services.mako = {
    enable = true;
    anchor = "bottom-right";
    margin = "24 12";
    padding = "24";
    defaultTimeout = 5000;
    borderRadius = 8;
    borderSize = 2;
  };

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;

    settings = let
      apps = "wofi --show drun --allow-images";
      terminal = "kitty";
      browser = "google-chrome-stable";
    in {
      env = [
        "BROWSER,${browser}"
        "XDG_CURRENT_DESKTOP,Hyprland"
        "HYPRCURSOR_THEME,capitaine-cursors"
        "HYPRCURSOR_SIZE,38"
        "XCURSOR_THEME,capitaine-cursors"
        "XCURSOR_SIZE,38"
        "QT_CURSOR_THEME,capitaine-cursors"
        "QT_CURSOR_SIZE,38"
      ];

      cursor = {
        enable_hyprcursor = false;
      };

      misc = {
        vrr = 1;
        animate_manual_resizes = true;
        animate_mouse_windowdragging = true;
      };

      exec-once = [
        "${pkgs.waybar}/bin/waybar"
        "hyprdim --no-dim-when-only --persist --ignore-leaving-special --dialog-dim"
        "blueman-tray"
      ];

      monitor = "DP-1,highrr,auto,auto";

      general = {
        border_size = 2;
        gaps_in = 8;
        gaps_out = "14 20 20 20";
      };

      decoration = {
        rounding = 8;
        drop_shadow = false;
        blur.enabled = true;
      };

      master = {
        allow_small_split = true;
        mfact = 0.32;
        new_on_top = false;
      };

      binds = {
        allow_workspace_cycles = true;
      };

      windowrule = let
        float = regex: "float, ^(${regex})$";
        floatTitle = regex: "float, title:^(${regex})$";
      in [
        (float "org.gnome.Calculator")
        (float "org.gnome.Calendar")
        (float "nm-connection-editor")
        (float "org.gnome.Settings")

        (float "xdg-desktop-portal")
        (float "xdg-desktop-portal-gnome")

        (floatTitle "Volume Control")
        (floatTitle "Bluetooth Devices")
      ];

      windowrulev2 = [
        "bordersize 0, fullscreen:1"
        "minsize 1000 650, floating:1"
        "opacity 0.88 0.88 1.0, title:(.*)$"
        "opacity 1.0, class:(google-chrome)"
      ];

      bindm = [
        "SHIFT_ALT, mouse:272, movewindow"
        "SHIFT_ALT, mouse:273, resizewindow"
      ];

      bind = let
        binding = mod: cmd: key: arg: "${mod}, ${key}, ${cmd}, ${arg}";
        bindExec = key: arg: "SUPER, ${key}, exec, ${arg}";
        mvfocus = binding "SUPER" "movefocus";
        resizeactive = binding "SUPER CTRL" "resizeactive";
        mvwindow = binding "SUPER ALT" "movewindow";
        ws = binding "SUPER" "workspace";
        mvtows = binding "SUPER ALT" "movetoworkspace";
        workspaces = [1 2 3 4 5];
      in
        [
          (bindExec "B" browser)
          (bindExec "T" terminal)
          (bindExec "A" apps)

          "SUPER, F, togglefloating"
          "SUPER ALT, F, fullscreen"
          "SUPER, Q, killactive"
          "SUPER CTRL, Q, exit"

          # ", Print, exec, grimblast copy area"

          # move window focus
          (mvfocus "K" "u")
          (mvfocus "J" "d")
          (mvfocus "L" "r")
          (mvfocus "H" "l")
          # move active window
          (mvwindow "K" "u")
          (mvwindow "J" "d")
          (mvwindow "L" "r")
          (mvwindow "H" "l")
          # resize active window
          (resizeactive "K" "0 -50")
          (resizeactive "J" "0 50")
          (resizeactive "L" "50 0")
          (resizeactive "H" "-50 0")
        ]
        ++ (map (i: ws (toString i) (toString i)) workspaces)
        ++ (map (i: mvtows (toString i) (toString i)) workspaces);
    };
  };

  services.hypridle = {
    enable = true;

    settings = {
      general = {
        after_sleep_cmd = "hyprctl dispatch dpms on";
        ignore_dbus_inhibit = false;
        lock_cmd = "hyprlock";
      };

      listener = [
        {
          timeout = 900;
          on-timeout = "hyprlock";
        }
        {
          timeout = 1200;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
      ];
    };
  };

  programs.hyprlock = {
    enable = true;

    settings = {
      disable_loading_bar = true;
      grace = 300;

      background = [
        {
          path = "screenshot";
          blur_passes = 3;
          blur_size = 8;
        }
      ];

      input-field = [
        {
          size = "200, 50";
          position = "0, -80";
          monitor = "";
          dots_center = true;
          fade_on_empty = false;
          font_color = "rgb(202, 211, 245)";
          inner_color = "rgb(91, 96, 120)";
          outer_color = "rgb(24, 25, 38)";
          outline_thickness = 5;
          placeholder_text = ''<span foreground="##cad3f5">Password...</span>'';
          shadow_passes = 2;
        }
      ];
    };
  };
}
