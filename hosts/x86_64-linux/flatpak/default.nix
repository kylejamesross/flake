{
  pkgs,
  lib,
  config,
  ...
}: {
  config = lib.mkIf config.my.gui.enable {
    services.flatpak.enable = true;

    # Flathub is configured declaratively. Individual applications are installed
    # manually with `flatpak install` because NixOS has no declarative package
    # option for Flatpak applications.
    systemd.services.flatpak-repo = {
      description = "Add the Flathub Flatpak remote";
      wantedBy = ["multi-user.target"];
      after = ["network-online.target"];
      wants = ["network-online.target"];
      path = [pkgs.flatpak];
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
      };
      script = ''
        flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
      '';
    };
  };
}
