{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.colors.default-dark;
  hexColorRegex = ''#([0-9a-fA-F]{3}){1,2}'';
  hexColor = {
    type = lib.types.strMatching hexColorRegex;
  };
in
{
  options.modules.colors.default-dark = {
    enable = lib.mkEnableOption "default-dark theme";
  };

  config = lib.mkIf cfg.enable {
    modules.scheme = {
      name = "base16-default-dark";
      base00 = "#181818";
      base01 = "#282828";
      base02 = "#383838";
      base03 = "#585858";
      base04 = "#b8b8b8";
      base05 = "#d8d8d8";
      base06 = "#e8e8e8";
      base07 = "#f8f8f8";
      base08 = "#ab4642";
      base09 = "#dc9656";
      base0A = "#f7ca88";
      base0B = "#a1b56c";
      base0C = "#86c1b9";
      base0D = "#7cafc2";
      base0E = "#ba8baf";
      base0F = "#a16946";
    };
  };
}
