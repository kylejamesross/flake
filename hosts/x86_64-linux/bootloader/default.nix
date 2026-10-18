{
  lib,
  config,
  pkgs,
  ...
}: {
  options.my.bootloader.enable = lib.mkEnableOption "Whether to enable bootloader";

  config = lib.mkIf config.my.bootloader.enable {
    boot = {
      kernelPackages = pkgs.linuxPackages_latest;
      loader = {
        systemd-boot = {
          enable = true;
          configurationLimit = 20;
        };
        efi.canTouchEfiVariables = true;
        timeout = 1;
      };
    };
  };
}
