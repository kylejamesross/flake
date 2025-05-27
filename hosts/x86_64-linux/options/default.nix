{lib, ...}: {
  imports = [
    ./monitors
    ./workspaces
  ];

  options.ags.enable = lib.mkEnableOption "Whether to enable ags";
}
