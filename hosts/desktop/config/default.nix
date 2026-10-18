_: {
  imports = [
    ./monitors
    ./workspaces
  ];

  config.my = {
    bootloader.enable = true;
    steam.enable = true;
    sunshine.enable = true;
    hyprland.enable = true;
    ags.enable = true;
    keyd.enable = true;
    gui.enable = true;
    vm.enable = true;
  };
}
