#
#  General Home-manager configuration
#

{ config, lib, pkgs, unstable, user, ... }:

{ 

  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";

    packages = with pkgs; [
      ansible
      git
      btop
      tldr
      gnutar
      unzip
      unrar
      zip
      curl
      lazygit
      tig
      ripgrep
      fd
      exa
      bat
      du-dust
      nodejs_18
      optipng
      gcc
      neofetch
      stow
      fzf
      tldr
      joplin
      nodePackages.typescript
      z-lua
    ];
  };

  programs = {
    home-manager.enable = true;
  };
}
