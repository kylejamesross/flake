{...}: {
  imports = [
    ./monitors
    ./workspaces
  ];

  config.bootloader.enable = true;
  config.steam.enable = true;
}
