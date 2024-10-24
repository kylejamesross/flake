{user, ...}: {
  networking.hostName = "wsl";
  wsl = {
    enable = true;
    defaultUser = user;
    docker-desktop.enable = false;
    startMenuLaunchers = false;
  };
  config.steam.enable = false;
  config.hyprland.enable = false;
  config.ags.enable = false;
  config.defaultNote = "WORK-TODO.md";
}
