{ config, lib, pkgs, ... }:
let
  cfg = config.modules.wob;
  scheme = config.modules.scheme;
  fmt = col: lib.strings.removePrefix "#" col;
in
{
  options.modules.wob = {
    enable = lib.mkEnableOption "wob";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      bat
      fd
    ];
    services.wob = {
      enable = true;
      systemd = true;
      settings = {
        "" = {
          timeout = 1000;
          bar_color = fmt scheme.base05;
          background_color = fmt scheme.base00;
          border_color = fmt scheme.base0D;
          width = 200;
          margin = 8;
          border_size = 1;
          border_offset = 0;
          overflow_mode = "nowrap";
          anchor = "top right";
          height = 25;
        };
      };
    };
  };
}
