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
    ./programs/vm

    ./services/greetd
    ./services/keyd
    ./services/nextcloud-autosync
    ./services/pipewire
    ./services/printing
    ./services/secrets
  ];

  services = {
    open-webui.enable = true;
    globalprotect.enable = true;
  };

  programs = {
    dconf.enable = true;
    git.enable = true;
  };

  environment.systemPackages = with pkgs; [
    bash
    xdg-utils
    inetutils
    cifs-utils
    unstable.gpclient
    globalprotect-openconnect
    gp-saml-gui
    remmina
  ];
}
