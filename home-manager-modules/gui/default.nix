{
  inputs,
  pkgs,
  lib,
  osConfig,
  ...
}: {
  imports = lib.optionals osConfig.my.gui.enable [
    ./programs/ags
    ./programs/firefox
    ./programs/hyprland
    ./programs/kitty
    ./programs/mime
    ./services/home-manager-system-tray
    ./services/hypridle
    ./services/kdeconnect
  ];

  config = lib.mkIf osConfig.my.gui.enable {
    programs = {
      mangohud.enable = true;
      mpv.enable = true;
      hyprlock.enable = true;
    };

    services = {
      cliphist.enable = true;
    };

    home = {
      packages = with pkgs; [
        alsa-utils
        brightnessctl
        dbus
        grim
        hyprdim
        hyprpaper
        krita
        libreoffice-still
        lorien
        lf
        pamixer
        pdfarranger
        piper
        playerctl
        satty
        slurp
        wl-clipboard
        wlr-randr
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
    };

    xdg.configFile."wallpapers" = {
      source = inputs.wallpapers;
      recursive = true;
    };
  };
}
