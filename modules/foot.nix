{ config, lib, pkgs, ... }:
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
          font ="monospace:size=12";
          title="term";
          resize-by-cells="no";
          pad="0x0 center";
        };

        desktop-notifications.command = "notify-send -a \${app-id} -i \${app-id} \${title} \${body}";
        url.label-letters="arstneio";

        cursor = {
          style="block";
          blink="no";
          color="0f0f0f cacaca";
        };

        colors = {
          alpha=0.7;
          # foreground="cacaca";
          # background="0f0f0f";
          # regular0="0f0f0f";
          # regular1="ac8a8c";
          # regular2="8aac8b";
          # regular3="aca98a";
          # regular4="8f8aac";
          # regular5="ac8aac";
          # regular6="8aabac";
          # regular7="cacaca";
          # bright0="262626 ";
          # bright1="c49ea0 ";
          # bright2="9ec49f ";
          # bright3="c4c19e ";
          # bright4="a39ec4 ";
          # bright5="c49ec4 ";
          # bright6="9ec3c4 ";
          # bright7="f5f5f5 ";
          # "16"="ceb188";
          # "17"="ac8a8c";
          # "18"="191919";
          # "19"="262626";
          # "20"="ac8a8c";
          # "21"="e7e7e7";
          foreground=fmt scheme.base05;
          background=fmt scheme.base00;
          regular0=fmt scheme.base00;
          regular1=fmt scheme.base08;
          regular2=fmt scheme.base0B;
          regular3=fmt scheme.base0A;
          regular4=fmt scheme.base0D;
          regular5=fmt scheme.base0E;
          regular6=fmt scheme.base0C;
          regular7=fmt scheme.base05;
          bright0=fmt scheme.base02;
          bright1=fmt scheme.base08;
          bright2=fmt scheme.base0B;
          bright3=fmt scheme.base0A;
          bright4=fmt scheme.base0D;
          bright5=fmt scheme.base0E;
          bright6=fmt scheme.base0C;
          bright7=fmt scheme.base07;
          "16"=fmt scheme.base09;
          "17"=fmt scheme.base0F;
          "18"=fmt scheme.base01;
          "19"=fmt scheme.base02;
          "20"=fmt scheme.base04;
          "21"=fmt scheme.base06;
        };
      };
    };
  };
}
