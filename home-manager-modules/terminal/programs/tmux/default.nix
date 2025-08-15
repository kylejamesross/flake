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

          set -g status off
        '';
      plugins = with pkgs; [
        tmuxPlugins.open
      ];
    };
  };
}
