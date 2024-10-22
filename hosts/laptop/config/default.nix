{...}: {
  imports = [
    ./monitors
  ];
  config.bootloader.enable = true;
  config.steam.enable = false;
}
