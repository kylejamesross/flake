#
#  Specific system configuration settings for all systems
#

{ pkgs, lib, user, ... }:

{
  imports = [(import ../../modules/desktop/hyprland/default.nix)];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 20;
      };
      efi.canTouchEfiVariables = true;
      timeout = 1;
    };
  };

  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  security = {
    rtkit.enable = true;
    polkit.enable = true;
    pam.services.swaylock = {
      text = ''
       auth include login
      '';
    };
  };

  fonts.fonts = with pkgs; [
    carlito
    vegur
    source-code-pro
    jetbrains-mono
    font-awesome
    corefonts
    noto-fonts
    noto-fonts-emoji
    (nerdfonts.override {
      fonts = [
        "JetBrainsMono"
      ];
    })
  ];

  services = {
    printing = {
      enable = true;
      drivers = [ pkgs.samsung-unified-linux-driver ];
      cups-pdf.enable = true;
    };
    keyd = {
      enable = true;
      settings = {
        main = {
          capslock = "overload(control, esc)";
        };
      };
    };
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
      jack.enable = true;
    };
    openssh = {
      enable = false;
      allowSFTP = true;
      extraConfig = ''
        HostKeyAlgorithms +ssh-rsa
      '';
    };
    gnome.gnome-keyring.enable = true;
    flatpak.enable = true;
  };

  networking = {
    firewall.enable = false;
    networkmanager = {
      enable = true;
      plugins = [ pkgs.networkmanager-openconnect ];
    };
  };

  virtualisation.docker.enable = true;

  hardware = {
    opengl = {
      enable = true;
    };
  };
}