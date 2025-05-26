{pkgs}:
pkgs.writeShellScriptBin "tmux-sessionizer" ''
  git_sessions=$(${pkgs.fd}/bin/fd . "/home/$USER" --min-depth 1 --max-depth 3 --type d --exec sh -c 'test -e "$1/.git" && echo "$1"' sh {} \;)

  if [ -d "/home/$USER/source/workspace" ]; then
    tf_sessions=$(${pkgs.fd}/bin/fd . "/home/$USER/source/workspace" --min-depth 1 --max-depth 1 --type d --exec sh -c 'test -e "$1/.tfignore" && echo "$1"' sh {} \;)
  else
    tf_sessions=""
  fi

  session=$(printf '%s\n%s\n' "$git_sessions" "$tf_sessions" | ${pkgs.fzf}/bin/fzf)

  session_name=$(basename "$session" | tr ".,: " "____")

  switch_to() {
    if [[ -z "$TMUX" ]]; then
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
''
