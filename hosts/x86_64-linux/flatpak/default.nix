{pkgs, ...}: {
  services.flatpak.enable = true;

  systemd.services.flatpak-repo = {
    enable = true;
    wantedBy = ["multi-user.target"];
    path = [pkgs.flatpak];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
      flatpak install -y --or-update flathub org.inkscape.Inkscape || true
      flatpak install -y --or-update flathub io.github.flattool.Warehouse || true
      flatpak install -y --or-update flathub io.dbeaver.DBeaverCommunity || true
    '';
  };

  environment.systemPackages = with pkgs; [
    flatpak
  ];
}
