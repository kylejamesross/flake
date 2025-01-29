{lib, ...}: {
  imports = [
    ./monitors
    ./workspaces
  ];

  options.ags.enable = lib.mkEnableOption "Whether to enable ags";
  options.ollama.enable = lib.mkEnableOption "Whether to enable ollama";
}
