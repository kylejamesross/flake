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
    globalprotect.enable = true;
    tailscale.enable = true;
  };

  environment.systemPackages = with pkgs; [
    globalprotect-openconnect
    gpclient
    gpauth
  ];

  nixpkgs.config = {
    permittedInsecurePackages = [
      "qtwebengine-5.15.19"
    ];
  };
}
