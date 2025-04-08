{ config, lib, pkgs, ... }:
let
  cfg = config.modules.colors.grayscale-light;
  hexColorRegex = ''#([0-9a-fA-F]{3}){1,2}'';
  hexColor = {
    type = lib.types.strMatching hexColorRegex;
  };
in
{
  options.modules.colors.grayscale-light = {
    enable = lib.mkEnableOption "grayscale-light theme";
  };

  config = lib.mkIf cfg.enable {
    modules.scheme = {
      light = true;
      name = "base16-grayscale-light";
      base00 = "#f7f7f7";
      base01 = "#e3e3e3";
      base02 = "#b9b9b9";
      base03 = "#ababab";
      base04 = "#525252";
      base05 = "#464646";
      base06 = "#252525";
      base07 = "#101010";
      base08 = "#7c7c7c";
      base09 = "#999999";
      base0A = "#a0a0a0";
      base0B = "#8e8e8e";
      base0C = "#868686";
      base0D = "#686868";
      base0E = "#747474";
      base0F = "#5e5e5e";
    };
  };
}
