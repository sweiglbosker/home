{ config, lib, pkgs, ... }:
let
  cfg = config.modules.tmux;
in
{
  options.modules.tmux = {
    enable = lib.mkEnableOption "tmux";
  };

  config = {
    programs.tmux = lib.mkIf cfg.enable {
      enable = true;
      customPaneNavigationAndResize = true;
      prefix = "C-Space";
      mouse = true;
      keyMode = "vi";
      baseIndex = 1;
      escapeTime = 0;
      focusEvents = true;
      extraConfig = ''
        set-option -ga terminal-overrides ",xterm-256color:Tc"
        set-option -g default-terminal "screen-256color"

        set -g renumber-windows on

        bind w switch-client -T split
        bind t switch-client -T tab

        bind -T tab o choose-tree -Zw
        bind -T tab c kill-window # warn?
        bind -T tab m previous-window
        bind -T tab i next-window
        bind -T tab n new-window

        bind -T split i split-window -h 
        bind -T split n split-window
        bind c kill-pane

        bind m select-pane -L
        bind n select-pane -D
        bind e select-pane -U
        bind i select-pane -R

        bind -T copy-mode-vi m send-keys -X cursor-left
        bind -T copy-mode-vi n send-keys -X cursor-down
        bind -T copy-mode-vi e send-keys -X cursor-up
        bind -T copy-mode-vi i send-keys -X cursor-right

        bind -T copy-mode-vi j send-keys -X search-again
        bind -T copy-mode-vi J send-keys -X search-reverse

        bind -T copy-mode-vi k send-keys -X next-word-end
        bind -T copy-mode-vi K send-keys -X next-space-end

        bind -T copy-mode-vi M send-keys -X top-line
        bind -T copy-mode-vi N send-keys -X scroll-down
        bind -T copy-mode-vi E send-keys -X scroll-up 
        bind -T copy-mode-vi I send-keys -X bottom-line

        bind -r M resize-pane -L 10
        bind -r N resize-pane -D 10
        bind -r E resize-pane -U 10
        bind -r I resize-pane -R 10

        bind h select-pane -m
        bind j next-window
        bind l display-message
        bind K select-layout -E

        set -g status-style bg='#191919',fg='#4c4c4c'
        set-window-option -g window-status-style fg='#4c4c4c',bg='#191919'
        set-window-option -g window-status-current-style fg='#ac8aac',bg='#191919'

        set -g pane-border-style fg='#191919'
        set -g pane-active-border-style fg='#191919'
      '';
    };
  };
}
