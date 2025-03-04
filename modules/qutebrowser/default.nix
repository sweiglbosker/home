{ config, lib, pkgs, inputs, ... }:
let
  cfg = config.modules.qutebrowser;
in
{
  options.modules.qutebrowser = {
    enable = lib.mkEnableOption "sway";
    wrapWithNixGL = lib.mkEnableOption "NixGL Wrapper";
  };

  config = {
    programs.qutebrowser = lib.mkIf cfg.enable {
      enable = true;
      package = if cfg.wrapWithNixGL then config.lib.nixGL.wrap pkgs.qutebrowser else pkgs.qutebrowser;
      loadAutoconfig = true;
    };
  };
}
