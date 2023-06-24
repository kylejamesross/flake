#
#  Home-manager configuration for desktop
#

{ pkgs, ... }:

{
  imports =
    [
      ../../modules/desktop/hyprland/home.nix
    ];

  home = {
    packages = with pkgs; [
      ansible
      firefox
      brave
      okular
      vlc
      gimp
      libreoffice-still
      kitty
      pamixer
      playerctl
      xfce.thunar
      xfce.thunar-archive-plugin
      gnome.file-roller
      networkmanagerapplet
      waybar
      wofi
      grim
      swww
      slurp
      swappy
      wl-clipboard
      cliphist
      wlr-randr
      dbus
    ];
    pointerCursor = {
      gtk.enable = true;
      name = "Dracula-cursors";
      package = pkgs.dracula-theme;
      size = 16;
    };
    stateVersion = "22.05";
  };

  gtk = {
    enable = true;
    theme = {
      name = "Dracula";
      package = pkgs.dracula-theme;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    font = {
      name = "JetBrains Mono Medium";
    };
  };

  systemd.user.targets.tray = {
    Unit = {
      Description = "Home Manager System Tray";
      Requires = [ "graphical-session-pre.target" ];
    };
  };
}
