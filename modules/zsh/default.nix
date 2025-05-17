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
      defaultKeymap = "viins";
      dirHashes = {
        home = "~/home";
        dl = "~/dl";
        src = "~/src";
      };
      shellAliases = {
        ls = "eza";
        ll = "eza -l";
        hide = "swayhide";
        lg = "NO_COLOR= lazygit";
        gdb = "gdb -q";
        py = "ipython3";
        fetch = "fastfetch";
      };
      autosuggestion.enable = true;
      initExtra = ''
        source ~/.oh-my-zsh/themes/${cfg.theme}.zsh-theme 
        setopt nobeep
        export KEYTIMEOUT=1
        export NO_COLOR=1
#       export KEYTIMEOUT=20 # note, set higher if you want to use surround mode or any chording

        bindkey -M vicmd m vi-backward-char 
        bindkey -M vicmd n vi-down-line-or-history
        bindkey -M vicmd e vi-up-line-or-history
        bindkey -M vicmd i vi-forward-char

        bindkey -M vicmd N vi-join

        bindkey -M vicmd h vi-set-mark
        bindkey -M vicmd j vi-repeat-search
        bindkey -M vicmd k vi-forward-word-end
        bindkey -M vicmd l vi-insert

        bindkey -M vicmd J vi-rev-repeat-search

        # vim style backspace (im a young soul)
        bindkey -v '^?' backward-delete-char

        bindkey '^F' fzf-cd-widget
        bindkey -M vicmd / fzf-history-widget
#        bindkey -M vicmd " f" fzf-cd-widget
#        bindkey -M vicmd . fzf
        if [[ -n "$TMUX" ]]; then
        # TODO: fix continuum so i dont need this hack
          export TERM=screen-256color
        fi

        export PATH=$HOME:/.local/riscv/bin:$PATH:$HOME/.local/bin

        function zle-keymap-select() {
          case $KEYMAP in 
            vicmd) echo -ne '\e[1 q';; # block
            viins) echo -ne '\e[5 q';; # beam
            main) echo -ne '\e[5 q';; # beam
          esac
        }
        zle -N zle-keymap-select
        zle-line-init() {
          zle -K viins
          echo -ne '\e[5 q' # beam
        }
        zle -N zle-line-init
        echo -ne '\e[5 q'
        precmd() {
          print -Pn "\e]0;$(dirs -p | head -1)\e\\"
          print -Pn "\e]133;A\e\\"
          if ! builtin zle; then
            print -n "\e]133;D\e\\"
          fi
          echo -ne '\e[5 q'
        }
        function preexec {
          print -Pn "\e]0;''${(q)1}\e\\"
          print -n "\e]133;C\e\\"
        }
      '';
    };
  };
}

