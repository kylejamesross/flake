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
      unzip
      unrar
      zip
      git
      lf
      curl
      lazygit
      tig
      ripgrep
      fd
      exa
      du-dust
      nodejs_18
      gcc
      neofetch
      stow
      fzf
      tldr
      joplin
      nodePackages.typescript
    ];
  };

  programs = {
    home-manager.enable = true;
  };
}
