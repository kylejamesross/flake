{ pkgs, user, ... }:

{
    home = {
        packages = [
            (import ./work-commit-message { inherit pkgs; })
            (import ./personal-commit-message { inherit pkgs; })
            (import ./tmux-sessionizer { inherit pkgs; })
            (import ./swww-randomizer { inherit pkgs; })
            (import ./git-pull-all { inherit pkgs; })
            (import ./gpr { inherit pkgs; })
            (import ./unraid-mount-unmount { inherit pkgs user; })
            (import ./gnome-terminal { inherit pkgs; })
        ];
    };
}
