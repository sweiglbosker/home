{ pkgs, lib, ... }:
pkgs.buildFHSEnv rec {
  name = "ida";
  version = "9.1";
  targetPkgs = pkgs: with pkgs; [
    dbus
    wayland
    egl-wayland
    libGL
    cairo
    dbus
    fontconfig
    freetype
    glib
    gtk3
    libdrm
    libGL
    libkrb5
    libsecret
    libsForQt5.qtbase
    libunwind
    libxkbcommon
    libsecret
    openssl.out
    stdenv.cc.cc
    xorg.libICE
    xorg.libSM
    xorg.libX11
    xorg.libXau
    xorg.libxcb
    xorg.libXext
    xorg.libXi
    xorg.libXrender
    xorg.xcbutilimage
    xorg.xcbutilkeysyms
    xorg.xcbutilrenderutil
    xorg.xcbutilwm
    zlib
    curl.out
    (python313.withPackages (
      ps: with ps; [
        rpyc 
        keystone-engine
        yara-python
      ])
    )
  ];
  runScript = pkgs.writeScript "idapro.sh" ''
    set -e
    # ~/ida-pro-9.1/idapyswitch --auto-apply
    exec "~/ida-pro-9.1/ida"
  '';
  meta = {
    description = "The world's smartest and most feature-full disassembler";
    homepage = "https://hex-rays.com/ida-pro/";
    mainProgram = "ida";
    platforms = [ "x86_64-linux" ]; # Right now, the installation script only supports Linux.
  };
}
