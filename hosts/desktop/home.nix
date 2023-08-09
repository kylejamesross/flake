
#
#  Home-manager configuration for desktop
#

{ pkgs, unstable, ... }:

{
  imports =
    [
      ../../modules/desktop/hyprland/home.nix
    ];
}
