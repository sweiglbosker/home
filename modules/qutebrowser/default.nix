{ config, lib, pkgs, inputs, ... }:
let
  cfg = config.modules.qutebrowser;
in
{
  config = {
    programs.qutebrowser = {
      enable = true;
      package = config.lib.nixGL.wrap pkgs.qutebrowser;
      loadAutoconfig = true;
    };
  };
}
