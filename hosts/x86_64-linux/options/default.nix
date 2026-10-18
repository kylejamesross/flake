{lib, ...}: {
  imports = [
    ./monitors
    ./workspaces
  ];

  options.my = {
    ags.enable = lib.mkEnableOption "Whether to enable ags";
    gui.enable = lib.mkEnableOption "Whether to enable the graphical desktop environment";
    hyprland.enable = lib.mkEnableOption "Whether to enable hyprland";
  };
}
