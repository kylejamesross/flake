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
    };
    systemPackages = with pkgs; [
      git
      stow
      unstable.neovim
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
    userActivationScripts = {
      stow = {
        text = ''
          if [ -d "/home/${user}/flake" ]; then
            ${pkgs.stow}/bin/stow --restow --target='/home/${user}/' --dir='/home/${user}/flake/' .config
          fi
          if [ -d "/flake" ]; then
            ${pkgs.stow}/bin/stow --restow --target='/home/${user}/' --dir='/flake/' .config
          fi
          if [ -d "/mnt/flake" ]; then
            ${pkgs.stow}/bin/stow --restow --target='/home/${user}/' --dir='/mnt/flake/' .config
          fi
        '';
      };
    };
    stateVersion = "22.05";
  };
}
