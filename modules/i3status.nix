{ config, lib, pkgs, ... }:
let
  cfg = config.modules.i3status;
in
{
  options.modules.i3status = {
    enable = lib.mkEnableOption "i3status";
    battery = lib.mkEnableOption "battery module";
    wireless = lib.mkOption {
      type = lib.types.bool;
      description = "enable wifi module";
      default = true;
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
    ];
    programs.i3status = {
      enable = true;
      enableDefault = false;
      general = {
        colors = true;
        color_good = "#cacaca";
        color_degraded = "#aca98a";
        color_bad = "#ac8a8c";
        interval = 60;
        separator = " ";
      };
      modules = {
        "volume master" = {
          position = 1;
          settings = {
            format = " %volume";
            format_muted = "";
            device = "default";
#            mixer = "Master";
#            mixer_idx = 0;
          };
        };
        "wireless _first_" = {
          enable = cfg.wireless;
          position = 3;
          settings = {
            format_up = "%quality";
            format_down = "󰖪";
          };
        };
        "ethernet _first_" = {
          position = 2;
          enable = !cfg.wireless;
        };
        # i have some laptops that use bat1 
        "battery all" = {
          position = 4;
          enable = cfg.battery;
          settings = {
            format = "%status %percentage";
            format_percentage = "%.00f%s";
            status_chr = "󱐋";
            status_bat = "";
            status_idle = "󱐋";
          };
        };
        "tztime local" = {
          position = 10;
          settings = {
            format = " %-I:%M %P";
          };
        };
      };
    };
  };
}
