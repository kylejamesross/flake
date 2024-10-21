{pkgs, ...}: {
  imports = [
    ./programs/stylix
    ./programs/sops
    ./programs/steam
    ./services/printing
    ./services/secrets
    ./services/keyd
    ./services/pipewire
    ./services/greetd
    ./programs/shell
    ./programs/hyprland
    ./programs/nh
    ./programs/vm
  ];

  programs.dconf.enable = true;

  environment.systemPackages = with pkgs; [
    git
    vim
    bash
    pciutils
    usbutils
    xdg-utils
    inetutils
    cifs-utils
  ];

  services = {};
}
