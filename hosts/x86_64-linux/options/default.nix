{lib, ...}: {
  imports = [
    ./monitors
    ./workspaces
  ];

  options.ags.enable = lib.mkEnableOption "Whether to enable ags";

  options.defaultNote = lib.mkOption {
    type = lib.types.string;
    default = "TODO.md";
    description = "Default note file to open";
  };
  options.alternativeNote = lib.mkOption {
    type = lib.types.string;
    default = "WORK-TODO.md";
    description = "Alternative note file to open";
  };
}
