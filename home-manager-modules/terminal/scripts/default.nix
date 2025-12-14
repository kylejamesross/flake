{
  pkgs,
  user,
  ...
}: {
  home = {
    packages = [
      (import ./personal-commit-message {inherit pkgs;})
      (import ./tmux-sessionizer {inherit pkgs;})
      (import ./wallpaper-randomizer {inherit pkgs;})
      (import ./git-pull-all {inherit pkgs;})
      (import ./sb {inherit pkgs;})
      (import ./wr {inherit pkgs;})
      (import ./pb {inherit pkgs;})
      (import ./g {inherit pkgs;})
      (import ./musb {inherit pkgs;})
      (import ./generate-resume {inherit pkgs;})
      (import ./generate-resume-into-clipboard {inherit pkgs;})
      (import ./unraid-mount-unmount {inherit pkgs user;})
      (import ./gnome-terminal {inherit pkgs;})
      (import ./tf {inherit pkgs;})
      (import ./garmin-schedule-transfer {inherit pkgs;})
    ];
  };
}
