{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ./config
  ];

  boot.initrd.kernelModules = ["amdgpu"];
  services.xserver.videoDrivers = ["amdgpu"];
  networking.hostName = "desktop";
  hardware.xone.enable = false;

  services = {
    tailscale.enable = true;
  };

  environment.systemPackages = with pkgs; [
    gp-saml-gui
  ];
}
