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
      brightnessctl
      dbus
      krita
      grim
      hyprpaper
      libreoffice-still
      lorien
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
}
