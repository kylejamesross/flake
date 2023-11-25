#
#  Home-manager configuration for common
#

{ pkgs, unstable, nix-colors, ... }:

{
  imports = 
    [
      ../../modules/common/hyprland/home.nix
      ../../modules/common/firefox/home.nix
      ../../modules/services/mako/home.nix
      ../../modules/shell/tmux.nix
      ../../modules/common/kitty/home.nix
      ../../modules/common/gtk/home.nix
      ../../modules/common/swaylock/home.nix
      ../../modules/common/btop/theme/home.nix
      ../../modules/common/lf/home.nix
      ./mime.nix
    ];


  home = {
    packages = with pkgs; [
      thunderbird
        brave
        okular
        dbeaver
        vlc
        gimp
        inkscape
        joplin-desktop
        anki-bin
        libreoffice-still
        pdfarranger
        notepadqq
        pamixer
        selectdefaultapplication
        playerctl
        gnome.file-roller
        xfce.tumbler
        (
         xfce.thunar.override {
         thunarPlugins = [
         xfce.thunar-archive-plugin
         ];
         }
        )
        ffmpegthumbnailer
        waybar
        wofi
        grim
        swww
        slurp
        swappy
        swaylock-effects
        wl-clipboard
        wlr-randr
        dbus

# work
        azuredatastudio
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
    stateVersion = "22.05";
  };

  colorScheme = nix-colors.colorSchemes.catppuccin-macchiato;
  gtk = {
    enable = true;
    theme = {
      package = pkgs.adw-gtk3;
      name = "adw-gtk3";
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    font = {
      name = "JetBrains Mono";
    };
  };

  systemd.user.targets.tray = {
    Unit = {
      Description = "Home Manager System Tray";
      Requires = [ "graphical-session-pre.target" ];
    };
  };
}
