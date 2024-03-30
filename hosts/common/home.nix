#
#  Home-manager configuration for common
#

{ pkgs, user, nix-colors, ... }:

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
      ../../modules/common/lf/home.nix
      ./mime.nix
    ];


  home = {
    packages = with pkgs; [
        thunderbird
        brave
        dbeaver
        mpv
        gimp
        inkscape
        joplin-desktop
        nextcloud-client
        anki-bin
        calibre
        libreoffice-still
        pdfarranger
        pamixer
        playerctl
        alsa-utils
        gnome.file-roller
        (
         xfce.thunar.override {
         thunarPlugins = [
         xfce.thunar-volman
         xfce.thunar-archive-plugin
         ];
         }
        )
        ffmpegthumbnailer
        waybar
        wttrbar
        wofi
        grim
        swww
        slurp
        swappy
        swaylock-effects
        swayidle
        wl-clipboard
        wlr-randr
        dbus
        brightnessctl

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
      package = pkgs.adw-gtk3;
      name = "adw-gtk3";
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.catppuccin-papirus-folders.override {
        accent = "blue";
        flavor = "mocha";
      };
    };
    font = {
      name = "JetBrains Mono";
    };
  };
  qt = {
    enable = true;
    platformTheme = "gtk";
    style = {
      name = "adwaita-dark";
      package = pkgs.adwaita-qt;
    };
  };
  systemd.user.targets.tray = {
    Unit = {
      Description = "Home Manager System Tray";
      Requires = [ "graphical-session-pre.target" ];
    };
  };
systemd.user = {
    services.nextcloud-autosync = {
      Unit = {
        Description = "Auto sync Nextcloud";
        After = [ "network-online.target" ];
      };
      Service = {
        Type = "simple";
        ExecStart = "${pkgs.nextcloud-client}/bin/nextcloudcmd -h -n --path / /home/${user}/nextcloud https://nextcloud.kylejamesross.com";
        TimeoutStopSec = "180";
        KillMode = "process";
        KillSignal = "SIGINT";
      };
      Install.WantedBy = [ "default.target" ];
    };
    timers.nextcloud-autosync = {
      Unit.Description = "Automatic sync files with Nextcloud when booted up after 5 minutes then rerun every 60 minutes";
      Timer = {
        OnBootSec = "5min";
        OnUnitActiveSec = "60min";
      };
      Install.WantedBy = [ "default.target" "timers.target" ];
    };
  };
}
