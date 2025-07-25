{
  config,
  lib,
  pkgs,
  ...
}:
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
        # font = "GoMono Nerd Font Propo";
        font = "${pkgs.inter}/share/fonts/tuetype/InterVariable.ttf";
        "font-size" = 24;
        hint-font = false;

        # width = "60%";
        # height = "50%";
        width = "100%";
        height = "100%";
        padding-left = "35%";
        padding-top = "35%";

        input-color = scheme.base05;
        "text-color" = scheme.base02;
        "placeholder-color" = scheme.base00;

        "selection-background" = scheme.base00; # 151515
        "selection-color" = scheme.base05;
        "selection-background-padding" = "0, -1";

        "text-cursor-style" = "bar";
        "text-cursor-color" = scheme.base05;

        "prompt-text" = "\"\"";

        "background-color" = scheme.base00;
        num-results = 5;

        "outline-width" = 0;
        "border-width" = 0;
        hide-cursor = true;
        "hidden-character" = "";
        terminal = "foot";
        ascii-input = true;
      };
    };
  };
}
