{lib, ...}: let
  inherit (lib) mkOption types;
in {
  options.my.workspaces = mkOption {
    type = types.listOf types.str;
    default = [];
  };
}
