#
#  Specific system configuration settings for desktop
#

{ pkgs, lib, user, ... }:

{
  imports = [(import ./hardware-configuration.nix)];

  boot.initrd.kernelModules = [ "amdgpu" ];

  services = {
    printing = {
      enable = true;
      drivers = [ pkgs.samsung-unified-linux-driver ];
      cups-pdf.enable = true;
    };
    ratbagd.enable = true;
  };
}
