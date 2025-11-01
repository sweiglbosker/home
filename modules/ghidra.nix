{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.ghidra;
  scheme = config.modules.scheme;
  fmt = col: lib.strings.removePrefix "#" col;
in
{
  options.modules.ghidra = {
    enable = lib.mkEnableOption "ghidra";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.z3
      pkgs.python312Packages.z3-solver
      (pkgs.ghidra.withExtensions (p: with p; [
        ret-sync
        ghidra-firmware-utils
        ghidra-golanganalyzerextension
        kaiju
        sleighdevtools
        wasm
        ghidra-golanganalyzerextension
        ghidra-delinker-extension
      ]))
    ];
  };
}
