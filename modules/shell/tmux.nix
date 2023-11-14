#
# Shell
#tmp

{ pkgs, ... }:

{
  programs = {
    tmux = {
      enable = true;
      keyMode = "vi";
      historyLimit = 100000;
      extraConfig = ''
        set -s escape-time 100
        setw -g mouse on
        set-option -g focus-events on
        set-option -sa terminal-overrides ",alacritty:RGB"

        bind-key -T copy-mode-vi v send-keys -X begin-selection
        bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel
        set -s set-clipboard on

        bind-key -r f run-shell "tmux neww ~/flake/bin/tmux-sessionizer"
        bind-key -r h run-shell "tmux neww ~/flake/bin/cht"
        bind-key -r v run-shell "tmux neww -S -n lazygit lazygit"
        bind-key -r . run-shell "tmux neww -S -n bpytop btop"
        bind-key -r R run-shell "tmux source ~/.tmux.conf"
        bind-key -r , run-shell "tmux neww -S -n work_notes nvim -c ':Neorg workspace work'"
        bind-key -r m run-shell "tmux neww -S -n personal_notes nvim -c ':Neorg workspace personal'"
        bind-key -r / run-shell "tmux neww -S -n playground"
        bind-key -r t run-shell "tmux neww -S -n terminal"
        bind-key -r e run-shell "tmux neww -S -n nvim nvim"
        bind-key -r - run-shell "tmux neww -S -n tig tig"

        set -g default-terminal "screen-256color"
        set -ga terminal-overrides ",xterm-256color:Tc"

        set -g status-position top
        set -g status-right ""
        set-option -g status-left-length 100
        set -g status-left "#[bg=#bd93f9,fg=#282a36]#{?client_prefix,#[bg=#f1fa8c],}  #S #[fg=#bd93f9,bg=#282a36]#{?client_prefix,#[fg=#f1fa8c],}"
        set-option -g pane-border-style "fg=#44475a"
        set-option -g pane-active-border-style "fg=#6272a4"
        set-option -g message-style "bg=#44475a,fg=#f8f8f2"
        set-option -g status-style "bg=#44475a,fg=#f8f8f2"
        set-window-option -g window-status-activity-style "bold"
        set-window-option -g window-status-bell-style "bold"
        set-window-option -g window-status-current-format "#[fg=#f8f8f2,bg=#6272a4] #I #W "
        set-window-option -g window-status-format "#[fg=#f8f8f2]#[bg=#44475a] #I #W"
        '';
    };
  };
}
