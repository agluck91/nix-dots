{pkgs, ...}: {
  # Create systemd service
  # https://github.com/PixlOne/logiops/blob/5547f52cadd2322261b9fbdf445e954b49dfbe21/src/logid/logid.service.in
  systemd.services.logiops = {
    description = "Logitech Configuration Daemon";
    startLimitIntervalSec = 0;
    after = ["graphical.target"];
    wantedBy = ["graphical.target"];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.logiops_0_2_3}/bin/logid";
      User = "root";
    };
  };

  # Add a `udev` rule to restart `logiops` when the mouse is connected
  # https://github.com/PixlOne/logiops/issues/239#issuecomment-1044122412
  services.udev.extraRules = ''
    ACTION=="change", SUBSYSTEM=="power_supply", ATTRS{manufacturer}=="Logitech", ATTRS{model_name}=="Wireless Mouse MX Master 3", RUN{program}="${pkgs.systemd}/bin/systemctl --no-block try-restart logiops.service"
  '';

  # Configuration for logiops
  environment.etc."logid.cfg".text = ''
    devices: ({
      name: "Wireless Mouse MX Master 3";
      smartshift: {
        on: false;
        threshold: 12;
      };
      hiresscroll: {
        hires: true;
        target: false;
      };
      buttons: ({
        cid: 0xc3;
        action = {
          type: "Gestures";
          gestures: ({
            direction: "Left";
            mode: "OnRelease";
            action = {
              type = "Keypress";
              keys: ["KEY_F15"];
            };
          }, {
            direction: "Right";
            mode: "OnRelease";
            action = {
              type = "Keypress";
              keys: ["KEY_F16"];
            };
          }, {
            direction: "Down";
            mode: "OnRelease";
            action = {
              type: "Keypress";
              keys: ["KEY_F17"];
            };
          }, {
            direction: "Up";
            mode: "OnRelease";
            action = {
              type: "Keypress";
              keys: ["KEY_F18"];
            };
          }, {
            direction: "None";
            mode: "OnRelease";
            action = {
              type = "Keypress";
              keys: ["KEY_PLAYPAUSE"];
            };
          });
        };
      }, {
        cid: 0xc4;
        action = {
          type: "Keypress";
          keys: [ "KEY_LEFTCTRL", "KEY_LEFTALT", "KEY_M" ];
        };
      });
    });
  '';
}
