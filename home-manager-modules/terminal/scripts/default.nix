{ pkgs, user, ... }:

{
    home = {
        packages = [
            (import ./work-commit-message.nix { inherit pkgs; })
            (import ./personal-commit-message.nix { inherit pkgs; })
            (import ./tmux-sessionizer.nix { inherit pkgs; })
            (import ./swww-randomizer.nix { inherit pkgs; })
            (import ./git-pull-all.nix { inherit pkgs; })
            (import ./git-add-commit-push-pr.nix { inherit pkgs; })
            (import ./git-commit-push-pr.nix { inherit pkgs; })
            (import ./git-push-pr.nix { inherit pkgs; })
            (import ./unraid-mount-unmount.nix { inherit pkgs user; })
        ];
    };
}
