
#
#  Home-manager configuration for laptop
#

{ pkgs, unstable, ... }:

{
  imports =
    [
      ../../modules/laptop/hyprland/home.nix
    ];
}
