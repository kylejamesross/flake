#
#  Specific system configuration settings for laptop
#

{ pkgs, lib, user, ... }:

{
  imports = [(import ./hardware-configuration.nix)];
}
