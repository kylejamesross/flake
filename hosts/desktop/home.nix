#
#  Home-manager configuration for desktop
#

{ pkgs, ... }:

{
  imports =
    [
      ../../modules/desktop/hyprland/home.nix
    ];

  home = {
    packages = with pkgs; [
      ansible
      sshpass
      networkmanagerapplet
    ];
  };
}
