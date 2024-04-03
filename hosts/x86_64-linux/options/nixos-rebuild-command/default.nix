{ lib, ... }:

let
  inherit (lib) mkOption types;
in
{
  options.nixos-rebuild-command = mkOption {
      type = types.str;
      default = "";
  };
}
