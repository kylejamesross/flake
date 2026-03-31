{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./programs/ags
    ./programs/firefox
    ./programs/hyprland
    ./programs/kitty
    ./programs/mime
    ./programs/swappy
    ./services/home-manager-system-tray
    ./services/hypridle
  ];

  programs = {
    mangohud.enable = true;
    mpv.enable = true;
    hyprlock.enable = true;
  };

  home = {
    packages = with pkgs; [
      alsa-utils
      anki-bin
      brave
      brightnessctl
      calibre
      dbeaver-bin
      dbus
      krita
      grim
      inkscape
      hyprpaper
      libreoffice-still
      lorien
      pamixer
      pdfarranger
      piper
      playerctl
      slurp
      wl-clipboard
      wlr-randr
      xow_dongle-firmware
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
}
