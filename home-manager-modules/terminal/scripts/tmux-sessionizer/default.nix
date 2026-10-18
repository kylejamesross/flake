{pkgs}:
pkgs.writeShellApplication {
  name = "tmux-sessionizer";
  runtimeInputs = with pkgs; [
    bash
    coreutils
    fd
    fzf
    tmux
  ];
  text = ''
    git_sessions=$(fd . "$HOME" --min-depth 1 --max-depth 3 --type d --exec sh -c "test -e \"\$1/.git\" && echo \"\$1\"" sh {} \; || true)

    session=$(printf '%s\n' "$git_sessions" | fzf || true)
    if [ -z "$session" ]; then
      exit 0
    fi

    session_name=$(basename "$session" | tr ".,: " "____")

    switch_to() {
      if [ -z "''${TMUX:-}" ]; then
        tmux attach-session -t "$session_name"
      else
        tmux switch-client -t "$session_name"
      fi
    }

    if tmux has-session -t="$session_name" 2>/dev/null; then
      switch_to
    else
      tmux new-session -ds "$session_name" -c "$session"
      switch_to
    fi
  '';
}
