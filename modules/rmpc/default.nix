{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.rmpc;
in
{
  options.modules.rmpc.enable = lib.mkEnableOption "rmpc";

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.rmpc
    ];

    xdg.configFile."rmpc/config.ron".source = ./config.ron;
    xdg.configFile."rmpc/notify.sh" = {
      source = ./notify.sh;
      executable = true;
    };
  };
}
