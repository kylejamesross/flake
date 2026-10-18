{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ./config
  ];

  boot.initrd.kernelModules = ["amdgpu"];
  services.xserver.videoDrivers = ["amdgpu"];
  networking.hostName = "desktop";

  services = {
    tailscale.enable = true;
  };

  environment.systemPackages = with pkgs; [
    gp-saml-gui
    claude-code
  ];
}
