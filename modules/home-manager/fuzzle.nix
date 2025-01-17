{pkgs, ...}: {
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        match-mode = "fzf";
        match-counter = "yes";
        layer = "overlay";
        icon-theme = "Papirus-Dark";
        icons-enabled = "yes";
        horizontal-pad = 20;
        vertical-pad = 12;
        line-height = 22;
        prompt = ''"❯  "'';
        placeholder = "Apps";
      };

      border = {
        width = 3;
        radius = 8;
      };

      key-bindings = {
        delete-line-forward = "none";
        next = "Control+j";
        prev = "Control+k";
      };
    };
  };

  home.packages = [
    (pkgs.helpers.nodeJsScript "fuzzel-notifications")
  ];
}
