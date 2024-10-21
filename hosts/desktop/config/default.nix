{...}: {
  imports = [
    ./monitors
    ./workspaces
  ];

  config.bootloader.enable = true;
}
