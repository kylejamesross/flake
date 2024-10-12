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
  ];

  environment.systemPackages = with pkgs; [
    git
    vim
    nano
    killall
    pciutils
    usbutils
    wget
    curl
    xdg-utils
    bash
    inetutils
    zsh
    dconf
    cifs-utils
    flatpak
  ];

  services = {};
}
