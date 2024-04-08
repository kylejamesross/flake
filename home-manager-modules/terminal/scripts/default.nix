{ pkgs, user, ... }:

{
    home = {
        packages = [
            (import ./work-commit-message { inherit pkgs; })
            (import ./personal-commit-message { inherit pkgs; })
            (import ./tmux-sessionizer { inherit pkgs; })
            (import ./swww-randomizer { inherit pkgs; })
            (import ./git-pull-all { inherit pkgs; })
            (import ./git-add-commit-push-pr { inherit pkgs; })
            (import ./git-commit-push-pr { inherit pkgs; })
            (import ./git-push-pr { inherit pkgs; })
            (import ./unraid-mount-unmount { inherit pkgs user; })
        ];
    };
}
