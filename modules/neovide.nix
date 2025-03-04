{ config, lib, pkgs, ... }:
let
  cfg = config.modules.neovide;
in
{
  options.modules.neovide = {
    enable = lib.mkEnableOption "neovide";
    wrapWithNixGL = lib.mkEnableOption "NixGL wrapper";
  };

  config = {
    programs.neovide = lib.mkIf cfg.enable {
      enable = true;
      package = if cfg.wrapWithNixGL then config.lib.nixGL.wrap pkgs.neovide else pkgs.neovide;
      settings = {
        title-hidden = true;
        font = {
          normal = ["ComicShannsMono Nerd Font"];
          features = {
            "ComicShannsMono Nerd Font" = ["+ss01" "+ss07" "+ss11" "-calt" "+ss09" "+ss02" "+ss14"];
          };
          size = 11.0;
        };
      };
    };
  };
}
