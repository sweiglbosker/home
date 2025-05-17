{ config, lib, pkgs, ... }:
let
  cfg = config.modules.colors.mountain;
  hexColorRegex = ''#([0-9a-fA-F]{3}){1,2}'';
  hexColor = {
    type = lib.types.strMatching hexColorRegex;
  };
in
{
  options.modules.colors.mountain = {
    enable = lib.mkEnableOption "mountain theme";
  };

  config = lib.mkIf cfg.enable {
    modules.scheme = {
      name = "base16-mountain";
      base00 = "#0f0f0f";
      base01 = "#191919";
      base02 = "#262626";
      base03 = "#4c4c4c";
      base04 = "#ac8a8c";
      base05 = "#cacaca";
      base06 = "#e7e7e7";
      base07 = "#f0f0f0";
      base08 = "#ac8a8c";
      base09 = "#ceb188";
      base0A = "#aca98a";
      base0B = "#8aac8b";
      base0C = "#8aabac";
      base0D = "#8f8aac";
      base0E = "#ac8aac";
      base0F = "#ac8a8c";
    };
  };
}
