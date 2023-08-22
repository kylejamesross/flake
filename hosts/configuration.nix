#
#  Main system configuration. More information available in configuration.nix(5) man page.
#

{ config, lib, pkgs, inputs, user, unstable, ... }:

{
  imports = [
    ../modules/shell/tmux.nix
    ../modules/shell/zsh.nix
  ];

  users.users.${user} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "docker" ];
    shell = pkgs.zsh;
  };
  security.sudo.wheelNeedsPassword = false;

  time.timeZone = "America/Edmonton";
  i18n = {
    defaultLocale = "en_US.UTF-8";
  };
  environment.etc = {
    "openfortivpn/config" = {
      text = ''
        host = vpn.nudesolutions.com
        port = 8443
        username = kyler
      '';
    };
  };

  environment = {
    variables = {
      TERMINAL = "kitty";
      EDITOR = "nvim";
      VISUAL = "nvim";
      BAT_THEME = "Dracula";
      USERNAME = user;
      VSCODE_CODELLDB = "${pkgs.vscode-extensions.vadimcn.vscode-lldb}";
    };
    systemPackages = with pkgs; [
      git
      vim
      nano
      killall
      pciutils
      usbutils
      wget
      curl
      xdg-utils
      bash
      inetutils

      # base-devel
      autoconf
      automake
      bison
      debugedit
      fakeroot
      file
      findutils
      flex
      gcc            
      gettext
      gnugrep
      groff
      gzip
      libtool
      gnum4
      gnumake
      gnupatch
      pkgconf
      gnused
      sudo
      texinfo
      which
      nasm
    ];
  };

  programs = {
    steam.enable = true;
  };

  nix = {
    settings ={
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
    package = pkgs.nixVersions.unstable;
    registry.nixpkgs.flake = inputs.nixpkgs;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs          = true
      keep-derivations      = true
    '';
  };
  nixpkgs.config.allowUnfree = true;

  system = {
    autoUpgrade = {
      enable = true;
      dates = "Sat *-*-* 00:00:00";
      channel = "https://nixos.org/channels/nixos-unstable";
    };
    stateVersion = "22.05";
  };
}
