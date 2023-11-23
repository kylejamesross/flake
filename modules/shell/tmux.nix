#
# Shell
#tmp

{ pkgs, config, ... }:

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

        set-option -g status-style "fg=#${config.colorScheme.colors.base04},bg=#${config.colorScheme.colors.base01}"

        set-window-option -g window-status-style "fg=#${config.colorScheme.colors.base04},bg=default"

        set-window-option -g window-status-current-style "fg=#${config.colorScheme.colors.base0A},bg=default"

        set-option -g pane-border-style "fg=#${config.colorScheme.colors.base01}"
        set-option -g pane-active-border-style "fg=#${config.colorScheme.colors.base02}"

        set-option -g message-style "fg=#${config.colorScheme.colors.base05},bg=#${config.colorScheme.colors.base01}"

        set-option -g display-panes-active-colour "#${config.colorScheme.colors.base0B}"
        set-option -g display-panes-colour "#${config.colorScheme.colors.base0A}"

        set-window-option -g clock-mode-colour "#${config.colorScheme.colors.base0B}"

        set-window-option -g mode-style "fg=#${config.colorScheme.colors.base04},bg=#${config.colorScheme.colors.base02}"

        set-window-option -g window-status-bell-style "fg=#${config.colorScheme.colors.base01},bg=#${config.colorScheme.colors.base08}"


        set -g status-position top
        set -g status-right ""
        set-option -g status-left-length 100
        '';
    };
  };
}
