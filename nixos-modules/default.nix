{
  pkgs,
  unstable,
  ...
}: {
  imports = [
    ./programs/nh
    ./programs/shell
    ./programs/sops
    ./programs/steam
    ./programs/stylix

    ./services/greetd
    ./services/keyd
    ./services/nextcloud-autosync
    ./services/pipewire
    ./services/printing
    ./services/secrets
  ];

  services = {
    # globalprotect.enable = true;
    tailscale.enable = true;
  };

  programs = {
    dconf.enable = true;
    git.enable = true;
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    configPackages = [
      pkgs.xdg-desktop-portal-wlr
    ];
  };

  environment.systemPackages = with pkgs; [
    bash
    xdg-utils
    inetutils
    cifs-utils
    # unstable.gpclient
    # globalprotect-openconnect
    # gp-saml-gui
    remmina
  ];
}
