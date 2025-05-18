{
  pkgs,
  user,
  ...
}: {
  home = {
    packages = [
      (import ./personal-commit-message {inherit pkgs;})
      (import ./tmux-sessionizer {inherit pkgs;})
      (import ./swww-randomizer {inherit pkgs;})
      (import ./git-pull-all {inherit pkgs;})
      (import ./unraid-mount-unmount {inherit pkgs user;})
      (import ./gnome-terminal {inherit pkgs;})
      (import ./tf {inherit pkgs;})
    ];
  };
}
