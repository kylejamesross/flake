{...}: {
  imports = [
    ./monitors
  ];
  config.bootloader.enable = true;
  config.steam.enable = false;
  config.hyprland.enable = true;
  config.ags.enable = true;
  config.keyd.enable = true;
}
