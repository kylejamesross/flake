{ inputs, pkgs, ... }:

{
    imports = [
        ./mime.nix
        ./programs/thunar
        ./programs/hyprland
        ./programs/firefox
        ./programs/kitty
        ./programs/gtk
        ./programs/swaylock
        ./programs/swappy
        ./programs/waybar
        ./services/mako
        ./services/home-manager-system-tray
    ];

    home = {
        packages = with pkgs; [
            thunderbird
            brave
            dbeaver
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

            azure-cli
            insomnia
            jetbrains.rider
        ];

        pointerCursor = {
            gtk.enable = true;
            name = "Bibata-Modern-Ice";
            package = pkgs.bibata-cursors;
            size = 32;
        };
    };

    colorScheme = inputs.nix-colors.colorSchemes.catppuccin-mocha;

    gtk = {
        enable = true;
        theme = {
            package = pkgs.adw-gtk3;
            name = "adw-gtk3";
        };
        iconTheme = {
            name = "Papirus-Dark";
            package = pkgs.catppuccin-papirus-folders.override {
                accent = "blue";
                flavor = "mocha";
            };
        };
        font = {
            name = "JetBrains Mono";
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
}
