{ config, lib, pkgs, ... }:
let
  cfg = config.modules.mako;
  scheme = config.modules.scheme;
in
{
  options.modules.mako = {
    enable = lib.mkEnableOption "mako";
  };

  config = {
    services.mako = lib.mkIf cfg.enable {
      enable = true;
      backgroundColor = scheme.base00;
      textColor = scheme.base05;
      borderColor = scheme.base0D; #"#a39ec4ff";
      borderSize = 1;
      defaultTimeout = 20000;
      font = "monospace 10";
    };
    home.packages = with pkgs; [
      libnotify
    ];
  };
}
