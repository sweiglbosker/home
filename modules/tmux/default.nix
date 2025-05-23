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

    programs.sesh = {
      enable = true;
      enableTmuxIntegration = false;
      icons = false;
      settings = {
        default_session = {
          "startup_command" = "nvim +':FzfLua files'";
        };
      };
    };

    programs.tmux = {
      enable = true;
      customPaneNavigationAndResize = true;
      prefix = "C-Space";
      mouse = false;
      keyMode = "vi";
      baseIndex = 1;
      escapeTime = 0;
      focusEvents = true;
      shell = "${pkgs.zsh}/bin/zsh";
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
            set -g @continuum-save-interval '15' # minutes
          '';
        }
        # {
        #   plugin = vim.tmux-navigatior;
        #   extraConfig = ''
        #   set -g 
        #   '';
        # }

      ];
      extraConfig = 
      ''
        set -g default-terminal "screen-256color"
        # set -g default-command zsh # this fixes colors for some reason
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

        bind s choose-tree -Zs
        bind S choose-tree -Z
        bind p run-shell "sesh connect \"$(sesh list | fzf --tmux --no-sort --ansi)\""
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

        is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
            | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?\.?(view|l?n?vim?x?|fzf)(diff)?(-wrapped)?$'"

        bind-key -n M-C if-shell "$is_vim" "send-keys C-w; send-keys q" kill-pane

        # bind-key -n M-Enter "split-window -h; select-layout -E"
        bind-key -n M-Enter if-shell "tmux list-panes | wc -l | 'grep -q ^1$'" "split-window -h" "select-pane -t bottom-right; split-window -v; select-layout -E"
        bind-key -n M-f resize-pane -Z

        bind-key -n M-1 if-shell 'tmux select-window -t :1' ''' 'new-window -t :1'
        bind-key -n M-2 if-shell 'tmux select-window -t :2' ''' 'new-window -t :2'
        bind-key -n M-3 if-shell 'tmux select-window -t :3' ''' 'new-window -t :3'
        bind-key -n M-4 if-shell 'tmux select-window -t :4' ''' 'new-window -t :4'
        bind-key -n M-5 if-shell 'tmux select-window -t :5' ''' 'new-window -t :5'
        bind-key -n M-6 if-shell 'tmux select-window -t :6' ''' 'new-window -t :6'
        bind-key -n M-7 if-shell 'tmux select-window -t :7' ''' 'new-window -t :7'
        bind-key -n M-8 if-shell 'tmux select-window -t :8' ''' 'new-window -t :8'
        bind-key -n M-9 if-shell 'tmux select-window -t :9' ''' 'new-window -t :9'
        bind-key -n M-0 if-shell 'tmux select-window -t :0' ''' 'new-window -t :0'

        bind-key -n M-! if-shell "tmux join-pane -t :1" "" "new-window -dt :1; join-pane -t :1; select-pane -t top-left; kill-pane; select-layout -E"
        bind-key -n M-@ if-shell "tmux join-pane -t :2" "" "new-window -dt :2; join-pane -t :2; select-pane -t top-left; kill-pane; select-layout -E"
        bind-key -n M-# if-shell "tmux join-pane -t :3" "" "new-window -dt :3; join-pane -t :3; select-pane -t top-left; kill-pane; select-layout -E"
        bind-key -n M-$ if-shell "tmux join-pane -t :4" "" "new-window -dt :4; join-pane -t :4; select-pane -t top-left; kill-pane; select-layout -E"
        bind-key -n M-% if-shell "tmux join-pane -t :5" "" "new-window -dt :5; join-pane -t :5; select-pane -t top-left; kill-pane; select-layout -E"
        bind-key -n M-^ if-shell "tmux join-pane -t :6" "" "new-window -dt :6; join-pane -t :6; select-pane -t top-left; kill-pane; select-layout -E"
        bind-key -n M-& if-shell "tmux join-pane -t :7" "" "new-window -dt :7; join-pane -t :7; select-pane -t top-left; kill-pane; select-layout -E"
        bind-key -n M-* if-shell "tmux join-pane -t :8" "" "new-window -dt :8; join-pane -t :8; select-pane -t top-left; kill-pane; select-layout -E"
        bind-key -n M-( if-shell "tmux join-pane -t :9" "" "new-window -dt :9; join-pane -t :9; select-pane -t top-left; kill-pane; select-layout -E"
        bind-key -n M-) if-shell "tmux join-pane -t :0" "" "new-window -dt :0; join-pane -t :0; select-pane -t top-left; kill-pane; select-layout -E"

        bind-key -n 'M-m' if-shell "$is_vim" 'send-keys M-m' 'select-pane -L'
        bind-key -n 'M-n' if-shell "$is_vim" 'send-keys M-n' 'select-pane -D'
        bind-key -n 'M-e' if-shell "$is_vim" 'send-keys M-e' 'select-pane -U'
        bind-key -n 'M-i' if-shell "$is_vim" 'send-keys M-i' 'select-pane -R'
        bind-key -n 'M-M' if-shell "$is_vim" 'send-keys M-M' 'resize-pane -L 1'
        bind-key -n 'M-N' if-shell "$is_vim" 'send-keys M-N' 'resize-pane -D 1'
        bind-key -n 'M-E' if-shell "$is_vim" 'send-keys M-E' 'resize-pane -U 1'
        bind-key -n 'M-I' if-shell "$is_vim" 'send-keys M-I' 'resize-pane -R 1'

        bind-key -T root m if -F "#{==:#{pane_mode},tree-mode}" "send h" "send m"
        bind-key -T root n if -F "#{==:#{pane_mode},tree-mode}" "send j" "send n"
        bind-key -T root e if -F "#{==:#{pane_mode},tree-mode}" "send k" "send e"
        bind-key -T root i if -F "#{==:#{pane_mode},tree-mode}" "send l" "send i"

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

        bind -T copy-mode-vi v send-keys -X begin-selection
        bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel

        bind -r M resize-pane -L 10
        bind -r N resize-pane -D 10
        bind -r E resize-pane -U 10
        bind -r I resize-pane -R 10

        bind \[ swap-pane -U
        bind \] swap-pane -D

        bind v copy-mode

        bind h select-pane -m
        bind j next-window
        bind l display-message
        bind K select-layout -E

        set -g status-style bg='${scheme.base00}',fg='${scheme.base03}'
        set-window-option -g window-status-style fg='${scheme.base03}',bg='${scheme.base00}'
        set-window-option -g window-status-current-style fg='${scheme.base05}',bg='${scheme.base00}'

        set -g pane-border-style fg='${scheme.base01}'
        set -g pane-active-border-style fg='${scheme.base01}'
        set -g status-right ""
        set -g status-left ""
        set -g status-justify centre
        set -g status-position top

        # don't detach after killing the current session
        set -g detach-on-destroy off
      '';
    };
  };
}
