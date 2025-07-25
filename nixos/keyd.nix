{
  config,
  lib,
  inputs,
  pkgs,
  ...
}:
let
  cfg = config.nixos.keyd;
in
{
  options.nixos.keyd = {
    enable = lib.mkOption {
      description = "enable the keyd module";
      type = lib.types.bool;
      default = true;
    };
  };

  config = lib.mkIf cfg.enable {
    services.keyd = {
      enable = true;
      keyboards = {
        defaults = {
          ids = [ "*" ];
          settings = {
            main = {
              capslock = "overload(control, esc)";
              # esc = "capslock";
              leftcontrol = "layer(nav)";
              leftalt = "overload(leftalt, tab)"; # TODO: tab not working
              rightalt = "overload(symbols, enter)";
              rightcontrol = "overload(symbols, backspace)";
              # homerow mods
              # a = "lettermod(meta, a, 150, 200)";
              # s = "lettermod(alt, s, 150, 200)";
              # d = "lettermod(control, d, 150, 200)";
              # f = "lettermod(shift, f, 150, 200)";
              #
              # j = "lettermod(shift, j, 150, 200)";
              # k = "lettermod(control, k, 150, 200)";
              # l = "lettermod(alt, l, 150, 200)";
              # ";" = "lettermod(meta, ;, 150, 200)";
            };
            nav = {
              h = "left";
              j = "down";
              k = "up";
              l = "right";
            };
            symbols = {
              q = "[";
              w = "&";
              e = "*";
              r = "(";
              t = "]";
              a = ";";
              s = "$";
              d = "%";
              f = "^";
              g = "=";
              z = "`";
              x = "!";
              c = "@";
              v = "#";
              b = "\\";
              leftmeta = "(";
              leftalt = ")";
              space = "-";
            };
            "symbols+shift" = {
              q = "{";
              t = "}";
              a = ":";
              s = ''"'';
              d = "'";
              g = "+";
              z = "~";
              b = "|";
              space = "_";
            };
          };
          extraConfig = '''';
        };
      };
    };
  };
}
