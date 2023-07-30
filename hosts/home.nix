#
#  General Home-manager configuration
#

{ config, lib, pkgs, unstable, user, ... }:

{
  imports =
  [
 	../modules/editors/nvim/home.nix
  ];

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
      omnisharp-roslyn
    ];
  };

  programs = {
    home-manager.enable = true;
  };

  home.file.".config/btop/btop.conf".source = ../nix-config/btop/btop.conf;
  home.file.".config/git/.gitignore_global".source = ../nix-config/git/.gitignore_global;
  home.file.".config/git/config".source = ../nix-config/git/config;
  home.file.".config/kitty/kitty.conf".source = ../nix-config/kitty/kitty.conf;
  home.file.".config/lazygit/config.yml".source = ../nix-config/lazygit/config.yml;
  home.file.".config/mako/config".source = ../nix-config/mako/config;
  home.file.".config/swappy/config".source = ../nix-config/swappy/config;
  home.file.".config/swaylock/config".source = ../nix-config/swaylock/config;
  home.file.".config/waybar/config.jsonc".source = ../nix-config/waybar/config.jsonc;
  home.file.".config/waybar/style.css".source = ../nix-config/waybar/style.css;
  home.file.".config/waybar/nix-snowflake.svg".source = ../nix-config/waybar/nix-snowflake.svg;
  home.file.".config/wlogout/hibernate.png".source = ../nix-config/wlogout/hibernate.png;
  home.file.".config/wlogout/lock.png".source = ../nix-config/wlogout/lock.png;
  home.file.".config/wlogout/logout.png".source = ../nix-config/wlogout/logout.png;
  home.file.".config/wlogout/reboot.png".source = ../nix-config/wlogout/reboot.png;
  home.file.".config/wlogout/shutdown.png".source = ../nix-config/wlogout/shutdown.png;
  home.file.".config/wlogout/suspend.png".source = ../nix-config/wlogout/suspend.png;
  home.file.".config/wlogout/style.css".source = ../nix-config/wlogout/style.css;
  home.file.".face".source = ../nix-config/.face;
  home.file.".p10k.zsh".source = ../nix-config/.p10k.zsh;
  home.file.".zshrc".source = ../nix-config/.zshrc;
  home.file.".config/nvim" = {
    source = ../nix-config/nvim;
    recursive = true;
  };
}
