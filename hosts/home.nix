#
#  General Home-manager configuration
#

{ config, lib, pkgs, unstable, user, inputs, ... }:

{
  imports = [(import ../modules/editors/nvim/home.nix)];

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
        eza
        bat
        du-dust
        nodejs
        bun
        nodePackages.npm
        yarn
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
        nodePackages."@astrojs/language-server"
        rust-analyzer
        lua-language-server
        cargo
        rustc
        rustfmt
        omnisharp-roslyn

# debug adapters
        netcoredbg
        lldb
        vscode-extensions.vadimcn.vscode-lldb
        ];
  };

  programs = {
    home-manager.enable = true;
  };


  xdg.configFile."btop/btop.conf".source = ../nix-config/btop/btop.conf;
  xdg.configFile."git/.gitignore_global".source = ../nix-config/git/.gitignore_global;
  xdg.configFile."git/config".source = ../nix-config/git/config;
  xdg.configFile."lazygit/config.yml".source = ../nix-config/lazygit/config.yml;
  xdg.configFile."swappy/config".source = ../nix-config/swappy/config;
  xdg.configFile."waybar/config.jsonc".source = ../nix-config/waybar/config.jsonc;
  xdg.configFile."waybar/style.css".source = ../nix-config/waybar/style.css;
  xdg.configFile."waybar/nix-snowflake.svg".source = ../nix-config/waybar/nix-snowflake.svg;
  home.file.".face".source = ../nix-config/.face;
  home.file.".p10k.zsh".source = ../nix-config/.p10k.zsh;
  home.file.".zshrc".source = ../nix-config/.zshrc;
  xdg.configFile."nvim" = {
    source = ../nix-config/nvim;
    recursive = true;
  };
  xdg.configFile."lf/icons".source = ../nix-config/lf/icons;
}
