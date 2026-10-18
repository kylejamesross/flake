{
  pkgs,
  lib,
  config,
  user,
  ...
}: {
  options.my.vm.enable = lib.mkEnableOption "Whether to enable virtualisation support";

  config = lib.mkIf config.my.vm.enable {
    users.users.${user} = {
      extraGroups = ["libvirtd" "docker"];
    };

    environment.systemPackages = with pkgs; [
      virt-manager
      virt-viewer
      spice
      spice-gtk
      spice-protocol
      virtio-win
      win-spice
      adwaita-icon-theme
    ];

    virtualisation = {
      libvirtd = {
        enable = true;
        qemu = {
          swtpm.enable = true;
        };
      };
      spiceUSBRedirection.enable = true;
      docker.enable = true;
    };
    services.spice-vdagentd.enable = true;
  };
}
