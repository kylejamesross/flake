{
  inputs,
  pkgs,
  ...
}: {
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

  programs = {
    mpv.enable = true;
    mangohud.enable = true;
  };

  home = {
    packages = with pkgs; [
      brave
      dbeaver-bin
      gimp
      inkscape
      lorien
      anki-bin
      calibre
      libreoffice-still
      pdfarranger
      pamixer
      playerctl
      alsa-utils
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
