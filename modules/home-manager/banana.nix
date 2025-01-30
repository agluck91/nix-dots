{pkgs, ...}: {
  gtk.cursorTheme = {
    name = "banana-cursor";
    package = pkgs.banana-cursor;
    size = 96;
  };
}
