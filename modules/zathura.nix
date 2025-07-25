{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.zathura;
  scheme = config.modules.scheme;
  fmt = col: lib.strings.removePrefix "#" col;
in
{
  options.modules.zathura = {
    enable = lib.mkEnableOption "zathura";
  };

  config = lib.mkIf cfg.enable {
    programs.zathura = {
      enable = true;
      mappings = {
        m = "feedkeys <Left>";
        n = "feedkeys <Down>";
        e = "feedkeys <Up>";
        i = "feedkeys <Right>";
        "<S-j>" = "feedkeys N";
        "<S-k>" = "feedkeys E";
        "[normal] N" = "feedkeys <PageDown>";
        "[normal] E" = "feedkeys <PageUp>";
        "h" = "feedkeys m";
        "j" = "feedkeys n";
        "k" = "feedkeys e";
        "l" = "feedkeys i";
      };
      options = {
        font = "BerkeleyMonoPatched Nerd Font Propo 12";
        selection-clipboard = "clipboard";
        recolor = true;
        default-fg = scheme.base05;
        default-bg = scheme.base00;
        completion-fg = scheme.base05;
        completion-bg = scheme.base02;
        completion-highlight-fg = scheme.base05;
        completion-highlight-bg = scheme.base03;
        completion-group-bg = scheme.base02;
        completion-group-fg = scheme.base0E;

        statusbar-fg = scheme.base05;
        statusbar-bg = scheme.base01;
        notification-fg = scheme.base05;
        notification-bg = scheme.base01;

        inputbar-fg = scheme.base05;
        inputbar-bg = scheme.base01;

        recolor-lightcolor = scheme.base00;
        recolor-darkcolor = scheme.base05;
        index-active-fg = scheme.base05;
        index-active-bg = scheme.base01;

        render-loading-bg = scheme.base00;
        render-loading-fg = scheme.base05;

        highlight-color = scheme.base01;
        highlight-fg = scheme.base05;
        highlight-active-color = scheme.base05;
      };
    };
  };
}
