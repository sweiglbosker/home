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

    home.file.".gnupg/pinentry-dmenu.conf" = {
      text = ''
        asterisk= "";
        prompt = "";
        font = "ComicShannsMono Nerd Font Mono:size=13";
        prompt_fg = "#cacaca";
        prompt_bg = "#0d0d0d";
        normal_fg = "#4c4c4c";
        normal_bg = "#0d0d0d";
        select_fg = "#8aac8b";
        select_bg = "#0d0d0d";
        desc_fg = "#cacaca";
        desc_bg = "#0d0d0d";
        '';
    };
  };
}
