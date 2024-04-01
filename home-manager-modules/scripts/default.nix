{ pkgs, ... }:

{
    home = {
        packages = [
            (import ../scripts/work-commit-message.nix { inherit pkgs; })
                (import ../scripts/personal-commit-message.nix { inherit pkgs; })
                (import ../scripts/tmux-sessionizer.nix { inherit pkgs; })
                (import ../scripts/swww-randomizer.nix { inherit pkgs; })
                (import ../scripts/git-pull-all.nix { inherit pkgs; })
                (import ../scripts/git-add-commit-push-pr.nix { inherit pkgs; })
                (import ../scripts/git-commit-push-pr.nix { inherit pkgs; })
                (import ../scripts/git-push-pr.nix { inherit pkgs; })
        ];
    };
}
