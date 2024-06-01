{ inputs, pkgs, ... }:

{
    imports = [
        ./programs/mime
        ./programs/hyprland
        ./programs/firefox
        ./programs/kitty
        ./programs/swaylock
        ./programs/swappy
        ./programs/waybar
        ./services/mako
        ./services/home-manager-system-tray
    ];

    home = {
        packages = with pkgs; [
            brave
            dbeaver-bin
            mpv
            gimp
            inkscape
            joplin-desktop
            anki-bin
            calibre
            libreoffice-still
            pdfarranger
            pamixer
            playerctl
            alsa-utils
            wttrbar
            wofi
            grim
            swww
            slurp
            swayidle
            wl-clipboard
            wlr-randr
            dbus
            brightnessctl
            piper
            xow_dongle-firmware

            # work
            azure-cli
            insomnia
            jetbrains.rider
        ];

        pointerCursor = {
            size = 32;
        };
    };

    gtk = {
        enable = true;
        iconTheme = {
            name = "Papirus-Dark";
            package = pkgs.papirus-icon-theme;
        };
    };

    qt = {
        enable = true;
        platformTheme = "gtk";
        style = {
            name = "adwaita-dark";
            package = pkgs.adwaita-qt;
        };
    };

    xdg.configFile."wallpapers" = {
        source = inputs.wallpapers;
        recursive = true;
    };
}
