{ config, lib, pkgs, ... }:
let
  cfg = config.modules.zsh;
in
{
  options.modules.zsh = {
    enable = lib.mkEnableOption "zsh";
  };

  config = {
    home.packages = with pkgs; [
      zsh
      oh-my-zsh
      zsh-autosuggestions
    ];

    programs.zsh = lib.mkIf cfg.enable {
    	enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      oh-my-zsh = {
        enable = true;
        theme = "lambda";
      };
    };
  };
}
