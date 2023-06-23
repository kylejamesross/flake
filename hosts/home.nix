#
#  General Home-manager configuration
#

{ config, lib, pkgs, unstable, user, ... }:

{ 

  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";

    packages = with pkgs; [
      btop
      tldr
      firefox
      brave
      okular
      unzip
      unrar
      zip
      git
      kitty
      pamixer
      playerctl
      xfce.thunar
      xfce.thunar-archive-plugin
      gnome.file-roller
      lf
      curl
      lazygit
      tig
      networkmanagerapplet
      ripgrep
      fd
      exa
      du-dust
      nodejs_18
      gcc
      wofi
      neofetch
      stow
      fzf
      vlc
      gimp
      libreoffice-still
      tldr
      joplin
      nodePackages.typescript
    ];

    pointerCursor = {
      gtk.enable = true;
      name = "Dracula-cursors";
      package = pkgs.dracula-theme;
      size = 16;
    };
    stateVersion = "22.05";
  };

  programs = {
    home-manager.enable = true;
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
