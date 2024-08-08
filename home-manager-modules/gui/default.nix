{ inputs, pkgs, ... }:

{
    imports = [
        ./programs/mime
        ./programs/hyprland
        ./programs/ags
        ./programs/firefox
        ./programs/kitty
        ./programs/swaylock
        ./programs/swappy
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
            anki-bin

            # work
            azure-cli
            insomnia
            #jetbrains.rider
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
        platformTheme.name = "gtk";
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
