{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.obs-studio;
in
{
  options.modules.obs-studio = {
    enable = lib.mkEnableOption "obs-studio";
  };

  config = lib.mkIf cfg.enable {
    programs.obs-studio = {
      enable = true;
      package = pkgs.obs-studio.override { cudaSupport = true; };
      plugins = [
        pkgs.obs-studio-plugins.obs-vkcapture
        pkgs.obs-studio-plugins.wlrobs
      ];
    };
  };
}
