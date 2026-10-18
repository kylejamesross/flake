_: {
  imports = [
    ./monitors
  ];

  config.my = {
    bootloader.enable = true;
    gui.enable = true;
    hyprland.enable = true;
    ags.enable = true;
    keyd.enable = true;
  };
}
