{pkgs}:
pkgs.writeShellScriptBin "tmux-sessionizer" ''
  session=$(${pkgs.fd}/bin/fd . "/home/$USER" --min-depth 1 --max-depth 3 --type d --exec sh -c 'test -e "$1/.git" -o -e "$1/.tf" && echo "$1"' sh {} \; | ${pkgs.fzf}/bin/fzf)

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
