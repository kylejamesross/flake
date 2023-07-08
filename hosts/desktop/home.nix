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
      firefox
      brave
      okular
      vlc
      gimp
      inkscape
      libreoffice-still
      pdfarranger
      notepadqq
      kitty
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
      mako
      grim
      swww
      slurp
      swappy
      wlogout
      swaylock-effects
      wl-clipboard
      cliphist
      wlr-randr
      dbus

      cargo
      rustc
      docker-compose
      azure-cli
      insomnia
      dbeaver
      jetbrains.rider
      dotnet-sdk_7
      azuredatastudio
      powershell
      sqlcmd

      nodePackages.typescript-language-server
      nodePackages.vscode-langservers-extracted
      rust-analyzer
      lua-language-server
    ];
    pointerCursor = {
      gtk.enable = true;
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
      size = 32;
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
