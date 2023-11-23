#
#  Home-manager configuration for common
#

{ pkgs, unstable, nix-colors, ... }:

{
  imports = 
    [
    nix-colors.homeManagerModules.default
      ../../modules/common/hyprland/home.nix
      ../../modules/common/firefox/home.nix
      ../../modules/services/mako/home.nix
      ../../modules/shell/tmux.nix
      ../../modules/common/kitty/home.nix
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
        wlogout
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

  colorScheme = nix-colors.colorSchemes.catppuccin-mocha;
  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-Macchiato-Compact-Pink-Dark";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "pink" ];
        size = "compact";
        tweaks = [ "rimless" "black" ];
        variant = "macchiato";
      };
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
