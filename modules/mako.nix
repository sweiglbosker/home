{ config, lib, pkgs, ... }:
let
  cfg = config.modules.mako;
in
{
  options.modules.mako = {
    enable = lib.mkEnableOption "mako";
  };

  config = {
    services.mako = lib.mkIf cfg.enable {
      enable = true;
      backgroundColor = "#0f0f0fff";
      textColor = "#cacacaff";
      borderColor = "#a39ec4ff";
      borderSize = 1;
      defaultTimeout = 20000;
      font = "BerkeleyMonoPatched Nerd Font 10";
    };
  };
}
