{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.colors.kanagawa-dragon;
  hexColorRegex = ''#([0-9a-fA-F]{3}){1,2}'';
  hexColor = {
    type = lib.types.strMatching hexColorRegex;
  };
in
{
  options.modules.colors.kanagawa-dragon = {
    enable = lib.mkEnableOption "kanagawa-dragon theme";
  };

  config = lib.mkIf cfg.enable {
    modules.scheme = {
      name = "kanagawa-dragon";

      base00 = "#181616";
      base01 = "#282727";
      base02 = "#393836";
      base03 = "#625e5a";
      base04 = "#737c73";
      base05 = "#c5c9c5";
      base06 = "#c8c093";
      base07 = "#c5c9c5";
      base08 = "#c4746e";
      base09 = "#b6927b";
      base0A = "#c4b28a";
      base0B = "#8a9a7b";
      base0C = "#8ea4a2";
      base0D = "#8ba4b0";
      base0E = "#a292a3";
      base0F = "#b98d7b";
      base10 = "#12120f";
      base11 = "#0d0c0c";
      base12 = "#e46876";
      base13 = "#e6c384";
      base14 = "#87a987";
      base15 = "#7aa89f";
      base16 = "#7fb4ca";
      base17 = "#938aa9";

    };
  };
}
