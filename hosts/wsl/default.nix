{
  user,
  pkgs,
  config,
  ...
}: {
  imports = [
    ./config.nix
  ];
  networking.hostName = "wsl";
  wsl = {
    enable = true;
    defaultUser = user;
    docker-desktop.enable = false;
    startMenuLaunchers = false;
    wrapBinSh = true;

    extraBin = [
      {
        name = "bash";
        src = config.wsl.binShExe;
      }
    ];
  };
  systemd.services."user-runtime-dir@" = {
    overrideStrategy = "asDropin";
    unitConfig.ConditionPathExists = "!/run/user/%i";
  };
}
