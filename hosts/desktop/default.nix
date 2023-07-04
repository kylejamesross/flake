#
#  Specific system configuration settings for desktop
#

{ pkgs, lib, user, neovim-overlay, ... }:

{
  imports =
    [(import ./hardware-configuration.nix)] ++
    [(import ../../modules/desktop/hyprland/default.nix)];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    initrd.kernelModules = [ "amdgpu" ];

    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 5;
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
    networkmanager.enable = true;
  };

  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  nixpkgs.overlays = [
    neovim-overlay.overlay
  ];

  hardware = {
    opengl = {
      enable = true;
    };
  };
}
