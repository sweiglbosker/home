{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.mpv;
  scheme = config.modules.scheme;
in
{
  options.modules.mpv = {
    enable = lib.mkEnableOption "mpv";
  };

  config = lib.mkIf cfg.enable {
    programs.mpv = {
      enable = true;
    };
  };
}
