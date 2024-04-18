{ pkgs }:

# Fake gnome-terminal to allow xdg terminal applications to be run in terminal
pkgs.writeShellScriptBin "gnome-terminal" ''
${pkgs.kitty}/bin/kitty "$@"
''
