{ config, lib, pkgs, ... }:
let
  cfg = config.modules.py3status;
in
{
  options.modules.py3status = {
    enable = lib.mkEnableOption "py3status";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      (python3Packages.py3status.overrideAttrs (oldAttrs: {
        propagatedBuildInputs = with python3Packages; [ pytz tzlocal pygobject3 ] ++ oldAttrs.propagatedBuildInputs;
      }))
      i3status
    ];

    xdg.configFile."i3status/config".source = ./config;
  };
}
