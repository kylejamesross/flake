#
#  Main system configuration. More information available in configuration.nix(5) man page.
#

{ config, lib, pkgs, inputs, user, ... }:

{
  imports = (import ../modules/shell);

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
      neovim
      vim
      nano
      killall
      pciutils
      usbutils
      wget
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
          ${pkgs.stow}/bin/stow --restow --target='/home/${user}/' .config
        '';
      };
    };
    stateVersion = "22.05";
  };
}
