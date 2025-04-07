{ config, lib, pkgs, ... }:
let
  cfg = config.modules.tofi;
  scheme = config.modules.scheme;
in
{
  options.modules.tofi = {
    enable = lib.mkEnableOption "tofi";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
    ];
    programs.tofi = {
      enable = true;
      settings = {
        # font = "ComicShannsMono Nerd Font Mono 10";
        font = "BerkeleyMonoPatched Nerd Font 10";
        "font-size" = 15;

        width = "60%";
        height = "50%";

        "text-color" = scheme.base05;
        "placeholder-color" = scheme.base00;

        "selection-background" = scheme.base01; #151515
        "selection-color" = scheme.base0B;
        "selection-background-padding"= "0, -1";

        "text-cursor-style"="bar";
        "text-cursor-color"=scheme.base05;

        "prompt-text"="\"\"";

        "background-color"=scheme.base00;

        "outline-width" = 2;
        "outline-color" = scheme.base01;

        "border-width"=0;
        "border-color"="#00000000";


        "corner-radius"=8;

        "text-cursor" = true;
        "hidden-character" = "";
        terminal = "foot";
        ascii-input = true;
      };
    };
  };
}
