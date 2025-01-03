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
    ./programs/swaylock
    ./services/home-manager-system-tray
  ];

  programs = {
    mangohud.enable = true;
    mpv.enable = true;
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
      gimp
      grim
      inkscape
      libreoffice-still
      lorien
      pamixer
      pdfarranger
      piper
      playerctl
      slurp
      swayidle
      swww
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
