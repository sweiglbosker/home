{ config, lib, pkgs, inputs, ... }:
let
  cfg = config.modules.qutebrowser;
  scheme = config.modules.scheme;
in
{
  options.modules.qutebrowser = {
    enable = lib.mkEnableOption "qutebrowser";
    wrapWithNixGL = lib.mkEnableOption "NixGL Wrapper";
  };

  config = {
    programs.qutebrowser = lib.mkIf cfg.enable {
      enable = true;
      package = if cfg.wrapWithNixGL then config.lib.nixGL.wrap pkgs.qutebrowser else pkgs.qutebrowser;
      loadAutoconfig = false;
      extraConfig = ''
        ${builtins.readFile ./config.py}
        c.colors.completion.category.bg = "${scheme.base00}";
        c.colors.completion.category.border.top = "${scheme.base00}";
        c.colors.completion.category.border.bottom = "${scheme.base00}";
        c.colors.webpage.preferred_color_scheme = "${if scheme.light then "light" else "dark"}"
      '';
    };
  };
}
