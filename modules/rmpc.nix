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
    programs.rmpc = {
      enable = true;
    };
  };
}
