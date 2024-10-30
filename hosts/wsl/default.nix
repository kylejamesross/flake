{user, ...}: {
  imports = [
    ./config.nix
  ];
  networking.hostName = "wsl";
  wsl = {
    enable = true;
    defaultUser = user;
    docker-desktop.enable = false;
    startMenuLaunchers = false;
  };
}
