{pkgs, ...}: {
  imports = [
    ./programs/stylix
    ./programs/sops
    ./programs/steam
    ./programs/shell
    ./programs/hyprland
    ./programs/nh
    ./programs/vm

    ./services/printing
    ./services/secrets
    ./services/keyd
    ./services/pipewire
    ./services/greetd
    ./services/nextcloud-autosync
  ];

  programs = {
    dconf.enable = true;
    git.enable = true;
  };

  environment.systemPackages = with pkgs; [
    bash
    xdg-utils
    inetutils
    cifs-utils
  ];
}
