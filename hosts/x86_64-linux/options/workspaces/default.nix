{lib, ...}: let
  inherit (lib) mkOption types;
in {
  options.workspaces = mkOption {
    type = types.listOf (types.str);
    default = [];
  };
}
