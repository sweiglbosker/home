{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.fzf;
  scheme = config.modules.scheme;
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
        bg = scheme.base00;
        "bg+" = scheme.base01;
        # "bg+" = scheme.base01; # "#151515";
        query = scheme.base05 + ":regular";
        spinner = scheme.base0C;
        hl = scheme.base0D;
        "hl+" = scheme.base0D;
        header = scheme.base0D;
        info = scheme.base0A;
        pointer = scheme.base01;
        marker = scheme.base0D;
        fg = scheme.base05;
        "fg+" = scheme.base0B + ":regular";
        prompt = scheme.base0C;
      };
      tmux = {
        enableShellIntegration = true;
      };
      defaultCommand = "fd . $HOME";
      defaultOptions = [
        "--style minimal"
        "--bind ctrl-n:down,ctrl-e:up"
        # "--no-bold"
        # "--style full"
      ];
      fileWidgetOptions = [
        "--preview 'bat --style=numbers --theme base16 --line-range :500 {}'"
        #        "--preview 'head{}'"
      ];
    };
  };
}
