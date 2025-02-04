{
  pkgs,
  lib,
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

  home.packages = [
    (pkgs.helpers.pyScript "switch-display")
  ];

  programs.mpv.enable = true;

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    package = pkgs.hyprland;

    settings = let
      apps = "wofi --show drun --allow-images";
      terminal = "ghostty";
      browser = "google-chrome-stable";
      hyprlock = "hyprlock";
      obsidian = "obsidian";
      todoist = "todoist";
    in {
      env = [
        "BROWSER,${browser}"
        "XDG_CURRENT_DESKTOP,Hyprland"
        "HYPRCURSOR_THEME,Banana-Catppuccin-Mocha"
        "HYPRCURSOR_SIZE,56"
        "XCURSOR_THEME,Banana-Catppuccin-Mocha"
        "XCURSOR_SIZE,56"
        "QT_CURSOR_THEME,Banana-Catppuccin-Mocha"
        "QT_CURSOR_SIZE,56"
      ];

      cursor = {
        enable_hyprcursor = false;
      };

      misc = {
        vrr = 1;
        animate_manual_resizes = true;
        animate_mouse_windowdragging = true;
        disable_hyprland_logo = true;
        force_default_wallpaper = 0;
        focus_on_activate = true;
      };

      exec-once = [
        "hyprpanel"
        "hyprdim --no-dim-when-only --persist --ignore-leaving-special --dialog-dim"
        "hyprctl setcursor Banana-Catppuccin-Mocha 56"
        "blueman-tray"
        "switch-display"
      ];

      monitor = [
        "HDMI-A-1,preferred,auto,1"
        "DP-1,highrr,auto,auto"
      ];

      input.touchpad = {
        natural_scroll = true;
        disable_while_typing = true;
        clickfinger_behavior = 1;
      };

      gestures = {
        workspace_swipe = true;
        workspace_swipe_fingers = 3;
      };

      general = {
        border_size = 2;
        gaps_in = 8;
        gaps_out = "14 20 20 20";
      };

      decoration = lib.mkForce {
        rounding = 8;
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

      binde = [
        ", XF86MonBrightnessUp, exec, light -A 10"
        ", XF86MonBrightnessDown, exec, light -U 10"
      ];

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
        (floatTitle "1Password")
      ];
      windowrulev2 = [
        "size 640 360, title:(Picture-in-Picture)"
        "pin, title:^(Picture-in-Picture)$"
        "move 1906 14, title:(Picture-in-Picture)"
        "float, title:^(Picture-in-Picture)$"
        "bordersize 0, fullscreen:1"
        "opacity 0.88 0.88 1.0, title:(.*)$"
        "opacity 1.0, class:(google-chrome)"
        "opacity 1.0, class:(firefox)"
        "opacity 1.0, class:(com.obsproject.Studio)"
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
        workspaces = [1 2 3 4 5 6 7 8 9];
      in
        [
          (bindExec "B" browser)
          (bindExec "T" terminal)
          (bindExec "A" apps)
          (bindExec "Z" hyprlock)
          (bindExec "O" obsidian)
          (bindExec "D" todoist)

          "SUPER, F, togglefloating"
          "SUPER ALT, F, fullscreen"
          "SUPER, Q, killactive"
          "SUPER CTRL, Q, exit"
          "SUPER, I, workspace, e+1"
          "SUPER, U, workspace, e-1"

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

      background = lib.mkForce [
        {
          path = "screenshot";
          blur_passes = 3;
          blur_size = 8;
        }
      ];

      input-field = lib.mkForce [
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
