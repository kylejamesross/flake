
#
#  Home-manager configuration for desktop
#

{ pkgs, unstable, ... }:

{
  home = {
    packages = with pkgs; [
      piper
      xow_dongle-firmware
    ];
  };
}
