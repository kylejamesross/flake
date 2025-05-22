{
  config,
  pkgs,
  user,
  ...
}:
with config.lib.stylix.colors; {
  programs = {
    tmux = {
      enable = true;
      keyMode = "vi";
      mouse = true;
      historyLimit = 100000;
      extraConfig =
        /*
        bash
        */
        ''
          set -s escape-time 100
          setw -g mouse on
          set-option -g focus-events on
          set-option -sa terminal-overrides ",alacritty:RGB"
          set -g allow-passthrough on
          set -ga update-environment TERM
          set -ga update-environment TERM_PROGRAM

          bind-key -T copy-mode-vi v send-keys -X begin-selection
          bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel
          set -s set-clipboard on

          bind-key -r f run-shell "tmux neww tmux-sessionizer"
          bind-key -r v run-shell "tmux neww -S -n '󰊢' lazygit"
          bind-key -r . run-shell "tmux neww -S -n '󰊚' btop"
          bind-key -r R run-shell "tmux source ~/.tmux.conf"
          bind-key -r / run-shell "tmux neww -S -n ''"
          bind-key -r n run-shell "tmux neww -S -n '󰠮' nvim /home/${user}/notes/TODO.md"
          bind-key -r N run-shell "tmux neww -S -n '󰠮' nvim /home/${user}/notes/WORK-TODO.md"
          bind-key -r t run-shell "tmux neww -S -n ''"
          bind-key -r e run-shell "tmux neww -c '#{pane_current_path}' -S -n '' nvim"
          bind-key -r - run-shell "tmux neww -S -n '󱁊' tig"
          bind-key -r \' run-shell "tmux neww -S -n '󱋣' yazi"

          set -g default-terminal "screen-256color"
          set -ga terminal-overrides ",xterm-256color:Tc"

          set -g visual-activity off
          set -g visual-bell off
          set -g visual-silence off
          setw -g monitor-activity off
          set -g bell-action none
          run-shell "tmux set-environment -g OPENAI_API_KEY \"\$(cat $HOME/.openai-api-key)\""
          run-shell "tmux set-environment -g ANTHROPIC_API_KEY \"\$(cat $HOME/.anthropic_api_key)\""
          run-shell "tmux set-environment -g CLAUDE_API_KEY \"\$(cat $HOME/.anthropic_api_key)\""

          set-option -g status-style "bg=#${base00}"
          set-window-option -g window-status-format "#[bg=#${base00},fg=#${base0F}]#[bg=#${base0F},fg=#${base00}] #W  #I #[bg=#${base00},fg=#${base0F}]#[bg=#${base00}] "
          set-window-option -g window-status-current-format "#[bg=#${base00},fg=#${base0B}]#[bg=#${base0B},fg=#${base00}] #W  #I #[bg=#${base00},fg=#${base0B}]#[bg=#${base00}] "

          set -g status-left "#[bg=#${base00}]#[fg=#${base0D}]#{?client_prefix,#[fg=#${base0B}],}#[bg=#${base0D},fg=#${base00}]#{?client_prefix,#[bg=#${base0B}],}   #S   #[bg=#${base00}]#[fg=#${base0D}]#{?client_prefix,#[fg=#${base0B}],}#[bg=#${base00}]  "

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
      plugins = with pkgs; [
        tmuxPlugins.open
      ];
    };
  };
}
