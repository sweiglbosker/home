{ config, lib, pkgs, ... }:
let
  cfg = config.modules.foot;
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
          font="ComicShannsMono Nerd Font Mono:size=12";
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
          foreground="cacaca";
          background="0f0f0f";
          regular0="0f0f0f";
          regular1="ac8a8c";
          regular2="8aac8b";
          regular3="aca98a";
          regular4="8f8aac";
          regular5="ac8aac";
          regular6="8aabac";
          regular7="cacaca";
          bright0="262626 ";
          bright1="c49ea0 ";
          bright2="9ec49f ";
          bright3="c4c19e ";
          bright4="a39ec4 ";
          bright5="c49ec4 ";
          bright6="9ec3c4 ";
          bright7="f5f5f5 ";
          "16"="ceb188";
          "17"="ac8a8c";
          "18"="191919";
          "19"="262626";
          "20"="ac8a8c";
          "21"="e7e7e7";
        };
      };
    };
  };
}
