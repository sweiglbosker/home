{ config, lib, pkgs, ... }:
let
  cfg = config.modules.tofi;
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
        font = "ComicShannsMono Nerd Font Mono 10";
        "font-size" = 15;

        width = "60%";
        height = "50%";

        "text-color" = "#cacaca";
        "placeholder-color" = "#0f0f0f";

        "selection-background" = "#151515FF";
        "selection-color" = "#8aac8b";
        "selection-background-padding"= "0, -1";

        "text-cursor-style"="bar";
        "text-cursor-color"="#cacaca";

        "prompt-text"="";

        "background-color"="#0f0f0f";

        "outline-width" = 2;
        "outline-color" = "#191919";

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
