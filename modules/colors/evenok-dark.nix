{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.colors.evenok-dark;
  hexColorRegex = ''#([0-9a-fA-F]{3}){1,2}'';
  hexColor = {
    type = lib.types.strMatching hexColorRegex;
  };
in
{
  options.modules.colors.evenok-dark = {
    enable = lib.mkEnableOption "evenok-dark theme";
  };
  config = lib.mkIf cfg.enable {
    modules.scheme = {
      name = "base16-evenok-dark";
      base00 = "#000000";
      base01 = "#202020";
      base02 = "#303030";
      base03 = "#505050";
      base04 = "#b0b0b0";
      base05 = "#d0d0d0";
      base06 = "#e0e0e0";
      base07 = "#ffffff";
      base08 = "#f5708a";
      base09 = "#ee8122";
      base0A = "#b8a300";
      base0B = "#54bc5c";
      base0C = "#00bab3";
      base0D = "#00aff2";
      base0E = "#9095ff";
      base0F = "#d47ada";
      base10 = "#000000";
      base11 = "#202020";
      base12 = "#f5708a";
      base13 = "#b8a300";
      base14 = "#54bc5c";
      base15 = "#00bab3";
      base16 = "#9095ff";
      base17 = "#d47ada";
    };
  };
}
