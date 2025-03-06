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
      zsh-autosuggestions
      gitstatus
    ];

    # omz isn't actually used, directory is arbitrary
    home.file.".oh-my-zsh/themes" = {
      source = ./themes;
      recursive = true;
    };

    programs.zsh = {
    	enable = true;
      autocd = true;
      enableCompletion = true;
      dirHashes = {
        home = "~/home";
        dl = "~/dl";
        src = "~/src";
      };
      autosuggestion.enable = true;
      initExtra = ''
        source ~/.oh-my-zsh/themes/${cfg.theme}.zsh-theme 
      '';
    };
  };
}
