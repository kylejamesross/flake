{...}: {
  imports = [
    ./monitors
    ./workspaces
  ];

  config.bootloader.enable = true;
  config.steam.enable = true;
  config.sunshine.enable = true;
  config.hyprland.enable = true;
  config.ags.enable = true;
  config.keyd.enable = true;
}
