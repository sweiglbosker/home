{ config, lib, pkgs, ... }:
let
  cfg = config.modules.gpg;

  inherit (lib) mkEnableOption mkOption mkIf types;
in
{
  options.modules.gpg = {
    enable = mkEnableOption "gpg";
  };

  config = mkIf cfg.enable {
    services.gpg-agent = {
      enable = true;
      # TODO: look into forwarding and extra socket, seems useful
      enableBashIntegration = true;
      enableZshIntegration = true;
      # enableNushellIntegration = true;
      enableSshSupport = true;
      noAllowExternalCache = true;
      pinentryPackage = pkgs.pinentry-qt;
#      sshKeys = [ "36663E191B00E51513F90FA5CF2BCE8461C297CD" ];
    };
  };
}
