{ pkgs, lib }:

pkgs.buildFHSEnv {
  name = "binaryninja";
  targetPkgs =
    pkgs: with pkgs; [
      dbus
      fontconfig
      freetype
      libGL
      libxml2
      libxkbcommon
      (python312.withPackages (
        ps: with ps; [
          pypresence
          z3-solver
        ]
      ))
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
    exec "~/.local/opt/binaryninja/binaryninja"         # ! change this path if your installation is located somewhere else.
  '';
  meta = {
    description = "binaryninja";
    platforms = [ "x86_64-linux" ];
  };
}
