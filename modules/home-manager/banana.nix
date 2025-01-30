{pkgs, ...}: {
  gtk.cursorTheme = {
    name = "banana";
    path = pkgs.banana-cursor;
    size = 96;
  };
}
