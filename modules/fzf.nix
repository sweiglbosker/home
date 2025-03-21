{ config, lib, pkgs, ... }:
let
  cfg = config.modules.fzf;
in
{
  options.modules.fzf = {
    enable = lib.mkEnableOption "fzf";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      bat
      fd
    ];
    programs.fzf = {
      enable = true;
      enableZshIntegration = true;
      colors = {
        bg = "#0f0f0f";
        # "bg+" = "#0f0f0f";
        "bg+" = "#151515";
        spinner = "#8aabac";
        hl = "#8f8aac";
        header = "#8f8aac";
        info = "#aca98a";
        pointer = "#8aabac";
        marker = "red";
        fg = "#cacaca";
        "fg+" = "#8aac8b";
      };
      tmux = {
        enableShellIntegration = true;
      };
      defaultCommand = "fd . $HOME";
      defaultOptions = [
        "--style minimal"
        "--bind ctrl-n:down,ctrl-e:up"
        # "--style full"
      ];
      fileWidgetOptions = [
        "--preview 'bat --style=numbers --theme base16 --line-range :500 {}'"
#        "--preview 'head{}'"
      ];
    };
  };
}
