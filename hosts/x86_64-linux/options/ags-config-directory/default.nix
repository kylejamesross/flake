{ lib, ... }:

let
  inherit (lib) mkOption types;
in
{
  options.agsConfigDirectory = mkOption {
    type = types.path;
    default = ../../../../home-manager-modules/gui/programs/ags/desktop-config;
  };
}
