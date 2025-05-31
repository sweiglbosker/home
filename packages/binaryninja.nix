{ pkgs, lib }:

pkgs.buildFHSEnv {
  name = "binaryninja";
  targetPkgs = pkgs: with pkgs; [
    dbus
    fontconfig
    freetype
    libGL
    libxml2
    libxkbcommon
    python311
    (python311.withPackages(ps: with ps; [ pypresence]))
    xorg.libX11
    xorg.libxcb
    xorg.xcbutilimage
    xorg.xcbutilkeysyms
    xorg.xcbutilrenderutil
    xorg.xcbutilwm
    wayland
    zlib
    gdb
  ];
  runScript = pkgs.writeScript "binaryninja.sh" ''
    set -e
    exec "~/.opt/binaryninja/binaryninja"         # ! change this path if your installation is located somewhere else.
  '';
  meta = {
    description = "binaryninja";
    platforms = [ "x86_64-linux" ];
  };
}
