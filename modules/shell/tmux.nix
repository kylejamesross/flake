#
# Shell
#tmp

{ pkgs, config, ... }:

with config.colorScheme.colors;

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
        bind-key -r . run-shell "tmux neww -S -n btop btop"
        bind-key -r R run-shell "tmux source ~/.tmux.conf"
        bind-key -r / run-shell "tmux neww -S -n playground"
        bind-key -r t run-shell "tmux neww -S -n terminal"
        bind-key -r e run-shell "tmux neww -S -n nvim nvim"
        bind-key -r - run-shell "tmux neww -S -n tig tig"
        bind-key -r l run-shell "tmux neww -S -n lf lf"

        set -g default-terminal "screen-256color"
        set -ga terminal-overrides ",xterm-256color:Tc"

        set -g visual-activity off
        set -g visual-bell off
        set -g visual-silence off
        setw -g monitor-activity off
        set -g bell-action none

        set-option -g status-style "fg=#${base05},bg=#000000"
        set-option -g status-left-style "bg=#${base0D},fg=#${base00}"
        set-window-option -g window-status-style "bg=#${base04},fg=#${base05}"
        set-window-option -g window-status-current-style "bg=#${base02},fg=#${base05},bold"
        set-window-option -g window-status-format " #I #W "
        set-window-option -g window-status-current-format " #I #W "

        set -g status-left "  #S #[bg=#000000] "

        set-option -g pane-border-style "fg=#${base01}"
        set-option -g pane-active-border-style "fg=#${base03}"
        set-option -g message-style "fg=#${base05},bg=#${base01}"

        set-option -g display-panes-active-colour "#${base0B}"
        set-option -g display-panes-colour "#${base0A}"

        set-window-option -g mode-style "fg=#${base04},bg=#${base02}"
        set-window-option -g window-status-bell-style "fg=#${base01},bg=#${base08}"

        set -g status-position top
        set -g status-left-length 100
        set -g status-right ""
        '';
    };
  };
}
