{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.scheme;
  hexColorRegex = ''#([0-9a-fA-F]{3}){1,2}'';
  hexColor = {
    type = lib.types.strMatching hexColorRegex;
  };
in
{
  options.modules.scheme = {
    name = lib.mkOption {
      type = lib.types.str;
      description = "scheme name";
      example = "base16-default-dark";
    };
    light = lib.mkOption {
      type = lib.types.uniq lib.types.bool;
      default = false;
      description = "whether this is a light colorscheme";
    };
    base00 = lib.mkOption hexColor;
    base01 = lib.mkOption hexColor;
    base02 = lib.mkOption hexColor;
    base03 = lib.mkOption hexColor;
    base04 = lib.mkOption hexColor;
    base05 = lib.mkOption hexColor;
    base06 = lib.mkOption hexColor;
    base07 = lib.mkOption hexColor;
    base08 = lib.mkOption hexColor;
    base09 = lib.mkOption hexColor;
    base0A = lib.mkOption hexColor;
    base0B = lib.mkOption hexColor;
    base0C = lib.mkOption hexColor;
    base0D = lib.mkOption hexColor;
    base0E = lib.mkOption hexColor;
    base0F = lib.mkOption hexColor;
    base10 = lib.mkOption hexColor;
    base11 = lib.mkOption hexColor;
    base12 = lib.mkOption hexColor;
    base13 = lib.mkOption hexColor;
    base14 = lib.mkOption hexColor;
    base15 = lib.mkOption hexColor;
    base16 = lib.mkOption hexColor;
    base17 = lib.mkOption hexColor;
  };

  # config = lib.mkIf cfg.enable {
  # };
}
