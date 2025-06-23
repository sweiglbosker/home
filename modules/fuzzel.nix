{ config, lib, pkgs, ... }:
let
  cfg = config.modules.fuzzel;
  scheme = config.modules.scheme;
  fmt = col: lib.strings.removePrefix "#" col;
  opaque = col: (fmt col) + "ff";
in
{
  options.modules.fuzzel = {
    enable = lib.mkEnableOption "fuzzel";
  };

  config = {
    programs.fuzzel = lib.mkIf cfg.enable {
      enable = true;
      settings = {
        main = {
          font = "monospace:size=14";
          icons-enabled = false;
          anchor = "center";
          minimal-lines = true;
          horizontal-pad = 10;
          lines = 10;
        };
        colors = {
          background = opaque scheme.base00;
          text = opaque scheme.base04;
          prompt = opaque scheme.base0C;
          input = opaque scheme.base05;
          match = opaque scheme.base09;
          selection = opaque scheme.base01;
          selection-text = opaque scheme.base05;
          selection-match = opaque scheme.base0D;
          border = opaque scheme.base01;
        };
        border = {
          width = 3;
          radius = 0;
        };
      };
    };
  };
}
