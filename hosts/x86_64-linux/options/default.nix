{lib, ...}: {
  imports = [
    ./monitors
    ./workspaces
  ];

  options.ags.enable = lib.mkEnableOption "Whether to enable ags";
  options.hyprland.enable = lib.mkEnableOption "Whether to enable hyprland";
}
