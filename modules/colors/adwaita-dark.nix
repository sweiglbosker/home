{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.colors.adwaita-dark;
  hexColorRegex = ''#([0-9a-fA-F]{3}){1,2}'';
  hexColor = {
    type = lib.types.strMatching hexColorRegex;
  };
in
{
  options.modules.colors.adwaita-dark = {
    enable = lib.mkEnableOption "adwaita-dark theme";
  };

  config = lib.mkIf cfg.enable {
    modules.scheme = {
      name = "base16-adwaita-dark";
      base00 = "#1d1d20";
      base01 = "#242428";
      base02 = "#303030";
      base03 = "#383838";
      base04 = "#5e5c64";
      base05 = "#DEDDDA";
      base06 = "#c0bfbc";
      base07 = "#f6f5f4";
      base08 = "#c01c28";
      base09 = "#e66100";
      base0A = "#f5c211";
      base0B = "#2ec27e";
      base0C = "#0ab9dc";
      base0D = "#1c71d8";
      base0E = "#813d9c";
      base0F = "#a51d2d";
      base10 = "#121212";
      base11 = "#000000";
      base12 = "#ed333b";
      base13 = "#f8e45c";
      base14 = "#57e389";
      base15 = "#4fd2fd";
      base16 = "#62a0ea";
      base17 = "#c061cb";
    };
  };
}
