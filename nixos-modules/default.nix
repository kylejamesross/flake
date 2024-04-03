{ pkgs, ... }:

{
    imports = [
        ./programs/sops
        ./programs/steam
        ./services/printing
        ./services/secrets
        ./services/keyd
        ./services/pipewire
        ./services/greetd
        ./programs/zsh
        ./programs/hyprland
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
    ];

    services = {
        gnome.gnome-keyring.enable = true;
        gvfs.enable = true;
        tumbler.enable = true;
        tailscale.enable = true;
    };
}
