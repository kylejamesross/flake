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
      unstable.nodePackages.typescript
      nodePackages.svgo
      zoxide
      docker-compose

      # work
      powershell
      dotnet-sdk_7
      sqlcmd

      # lsp
      unstable.nodePackages.typescript-language-server
      unstable.nodePackages.vscode-langservers-extracted
      unstable.rust-analyzer
      unstable.lua-language-server
      unstable.cargo
      unstable.rustc
      omnisharp-roslyn
    ];
  };

  programs = {
    home-manager.enable = true;
  };

  home.file.".config/btop/btop.conf" = {
    source = "../nix-config/btop/btop.conf";
  };

}
