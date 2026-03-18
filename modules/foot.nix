{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.foot;
  scheme = config.modules.scheme;
  fmt = col: lib.strings.removePrefix "#" col;
in
{
  options.modules.foot = {
    enable = lib.mkEnableOption "foot";
  };

  config = {
    programs.foot = lib.mkIf cfg.enable {
      enable = true;
      server = {
        enable = true;
      };
      settings = {
        main = {
          font = "monospace:size=10";
          title = "term";
          resize-by-cells = "no";
          pad = "0x0 center";
        };

        desktop-notifications.command = "notify-send -a \${app-id} -i \${app-id} \${title} \${body}";
        url.label-letters = "arstneio";

        cursor = {
          style = "block";
          blink = "no";
        };

        colors-dark = {
          # alpha=0.7;
          cursor = (fmt scheme.base00) + " " + (fmt scheme.base05);
          foreground = fmt scheme.base05;
          background = fmt scheme.base00;
          regular0 = fmt scheme.base01;
          regular1 = fmt scheme.base08;
          regular2 = fmt scheme.base0B;
          regular3 = fmt scheme.base0A;
          regular4 = fmt scheme.base0D;
          regular5 = fmt scheme.base0E;
          regular6 = fmt scheme.base0C;
          regular7 = fmt scheme.base06;
          bright0 = fmt scheme.base02;
          bright1 = fmt scheme.base12;
          bright2 = fmt scheme.base14;
          bright3 = fmt scheme.base13;
          bright4 = fmt scheme.base16;
          bright5 = fmt scheme.base17;
          bright6 = fmt scheme.base15;
          bright7 = fmt scheme.base07;
          "16" = fmt scheme.base09;
          "17" = fmt scheme.base0F;
          "18" = fmt scheme.base01;
          "19" = fmt scheme.base02;
          "20" = fmt scheme.base04;
          "21" = fmt scheme.base06;
        };
      };
    };
  };
}
