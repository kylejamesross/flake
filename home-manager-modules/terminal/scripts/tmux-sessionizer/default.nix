{ pkgs }:

pkgs.writeShellScriptBin "tmux-sessionizer" ''

session=$(${pkgs.fd}/bin/fd . "/home/$USER" --min-depth 1 --max-depth 3 --type d --exec sh -c 'test -e "$1/.git" && echo "$1"' sh {} \; | fzf)

session_name=$(echo "$session" | tr . _)

echo "$session_name"

if ! ${pkgs.tmux}/bin/tmux has-session -t "$session_name" 2> /dev/null; then
  ${pkgs.tmux}/bin/tmux new-session -s "$session_name" -c "$session" -n '' -d
fi

${pkgs.tmux}/bin/tmux switch-client -t "$session_name"

''
