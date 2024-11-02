{...}: {
  imports = [
    ./monitors
    ./workspaces
  ];

  config.bootloader.enable = true;
  config.steam.enable = true;
  config.hyprland.enable = true;
  config.ags.enable = true;
  config.keyd.enable = true;
}
