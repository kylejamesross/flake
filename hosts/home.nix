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
      btop
      tldr
      gnutar
      unzip
      unrar
      zip
      lazygit
      tig
      ripgrep
      fd
      exa
      bat
      du-dust
      nodejs
      nodePackages.npm
      optipng
      neofetch
      fzf
      tldr
      joplin
      nodePackages.typescript
      nodePackages.svgo
      zoxide
      docker-compose

      # work
      powershell
      dotnet-sdk_7
      sqlcmd

      # lsp
      nodePackages.typescript-language-server
      nodePackages.vscode-langservers-extracted
      rust-analyzer
      lua-language-server
      cargo
      rustc
    ];
  };

  programs = {
    home-manager.enable = true;
  };
}
