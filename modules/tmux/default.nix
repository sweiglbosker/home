{ config, lib, pkgs, ... }:
let
  cfg = config.modules.tmux;
  scheme = config.modules.scheme;
in
{
  options.modules.tmux = {
    enable = lib.mkEnableOption "tmux";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      fd
      fzf
      (writeShellScriptBin "session-load" "${builtins.readFile ./session-load.sh}")
    ];

    programs.tmux = {
      enable = true;
      customPaneNavigationAndResize = true;
      prefix = "C-Space";
      mouse = false;
      keyMode = "vi";
      baseIndex = 1;
      escapeTime = 0;
      focusEvents = true;
      plugins = with pkgs.tmuxPlugins; [
        {
          plugin = resurrect;
          extraConfig = ''
            set -g @resurrect-strategy-nvim 'session'
            set -g @resurrect-processes '"~ssh" lazygit'
          '';
        }
        {
          plugin = continuum;
          extraConfig = ''
            set -g @continuum-restore 'on'
          '';
        }
      ];
      extraConfig = ''
        set -g default-terminal "screen-256color"
        set -g default-command zsh # this fixes colors for some reason
        # undercurl support in neovim
        set -as terminal-overrides ',*:Smulx=\E[4::%p1%dm'
        # support colors for undercurl
        set -as terminal-overrides ',*:Setulc=\E[58::2::%p1%{65536}%/%d::%p1%{256}%/%{255}%&%d::%p1%{255}%&%d%;m'
        set -g renumber-windows on

        bind R source-file ~/.config/tmux/tmux.conf

        bind w switch-client -T split
        bind t switch-client -T tab
        bind f switch-client -T file
        bind F switch-client -T dir

        bind d detach-client 

        bind -T tab o choose-tree -Zw
        bind -T tab c kill-window # warn?
        bind -T tab m previous-window
        bind -T tab i next-window
        bind -T tab n new-window

        bind -T dir o run-shell -b 'fd . -td | fzf --tmux --scheme=path | xargs --no-run-if-empty tmux split-window -h -c'
        bind -T dir O run-shell -b 'fd . -td | fzf --tmux --scheme=path | xargs --no-run-if-empty tmux new-window -c'
        bind -T file o run-shell -b 'fd . -tf | fzf --tmux --scheme=path | xargs --no-run-if-empty tmux split-window -h -c $(pwd) $EDITOR'
        bind -T file O run-shell -b 'fd . -tf | fzf --tmux --scheme=path | xargs --no-run-if-empty tmux new-window -c $(pwd) $EDITOR'

        bind -T split i split-window -h 
        bind -T split n split-window
        bind -T split w select-pane -t :.+
        bind c kill-pane

        bind m select-pane -L
        bind n select-pane -D
        bind e select-pane -U
        bind i select-pane -R

        bind-key -T root m if -F "#{==:#{pane_mode},tree-mode}" "send h" "send m"
        bind-key -T root n if -F "#{==:#{pane_mode},tree-mode}" "send j" "send n"
        bind-key -T root e if -F "#{==:#{pane_mode},tree-mode}" "send k" "send e"
        bind-key -T root i if -F "#{==:#{pane_mode},tree-mode}" "send l" "send i;"

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

        bind \[ swap-pane -U
        bind \] swap-pane -D

        bind v copy-mode
        bind F resize-pane -Z

        bind h select-pane -m
        bind j next-window
        bind l display-message
        bind K select-layout -E

        set -g status-style bg='${scheme.base00}',fg='${scheme.base03}'
        set-window-option -g window-status-style fg='${scheme.base03}',bg='${scheme.base00}'
        set-window-option -g window-status-current-style fg='${scheme.base0E}',bg='${scheme.base00}'

        set -g pane-border-style fg='${scheme.base01}'
        set -g pane-active-border-style fg='${scheme.base01}'

      '';
    };
  };
}
