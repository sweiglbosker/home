{ config, lib, pkgs, ... }:
let
  cfg = config.modules.zsh;

  inherit (lib) mkEnableOption mkOption mkIf types;
in
{
  options.modules.zsh = {
    enable = mkEnableOption "zsh";
    theme = mkOption {
      type = types.str;
      description = "name of zsh theme to apply";
      default = "stefan";
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      zsh
      oh-my-zsh
      zsh-autosuggestions
    ];

    home.file.".oh-my-zsh/themes" = {
      source = ./themes;
      recursive = true;
    };

    programs.zsh = {
    	enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      oh-my-zsh = {
        enable = true;
      };
      initExtra = ''
        source ~/.oh-my-zsh/themes/${cfg.theme}.zsh-theme 
      '';
    };
  };
}
