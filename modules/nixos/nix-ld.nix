{pkgs, ...}: {
  programs.nix-ld.enable = true;

  # Add any missing dynamic libraries for unpackaged programs
  # here, NOT in environment.systemPackages
  programs.nix-ld.libraries = with pkgs; [
    volta
    alsa-lib
    at-spi2-atk
    at-spi2-core
    atk
    cairo
    cups
    curl
    dbus
    expat
    fontconfig
    freetype
    fuse3
    gdk-pixbuf
    glib
    icu
    libGL
    libappindicator-gtk3
    libdrm
    libglvnd
    libnotify
    libpulseaudio
    libunwind
    libusb1
    libuuid
    libxkbcommon
    libxml2
    rustc
    cargo
    nspr
    nss
    openssl
    pango
    pipewire
    stdenv.cc.cc
    stdenv.cc.cc.lib
    vips
    gcc
    libgcc
    systemd
    vulkan-loader
    zlib
  ];
}
