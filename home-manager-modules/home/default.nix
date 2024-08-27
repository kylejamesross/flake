{ user, pkgs, ... }:

let editor = pkgs.writeShellScriptBin "editor" ''
    FILENAME="/home/${user}/.cache/nvim/$(pwd | md5sum | awk '{ print $1 }').pipe"
    if [ -n "$TMUX" ]; then
        if tmux list-windows | grep -q ''; then
            tmux neww -S -n '' && nvim --server $FILENAME --remote "$@"
        else
            tmux neww -n '' nvim --listen $FILENAME "$@"
        fi
    else
        nvim --server $FILENAME --remote-silent "$@"
    fi
'';
in
{
    home = {
        username = "${user}";
        homeDirectory = "/home/${user}";
        stateVersion = "22.05";
        sessionVariables = {
            EDITOR = ''${editor}/bin/editor'';
        };
    };
    programs.home-manager.enable = true;
    stylix.targets.waybar.enable = false;
}
