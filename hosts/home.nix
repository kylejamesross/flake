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
        tealdeer
        gnutar
        unzip
        unrar
        zip
        yazi
        lazygit
        tig
        shell_gpt
        gh
        ripgrep
        jaq
        fd
        eza
        bat
        du-dust
        nodejs_20
        bun
        yarn
        optipng
        neofetch
        fzf
        nodePackages.typescript
        nodePackages.svgo
        zoxide
        docker-compose
        (import ../scripts/work-commit-message.nix { inherit pkgs; })
        (import ../scripts/personal-commit-message.nix { inherit pkgs; })
        (import ../scripts/tmux-sessionizer.nix { inherit pkgs; })
        (import ../scripts/swww-randomizer.nix { inherit pkgs; })
        (import ../scripts/git-pull-all.nix { inherit pkgs; })
        (import ../scripts/git-add-commit-push-pr.nix { inherit pkgs; })
        (import ../scripts/git-commit-push-pr.nix { inherit pkgs; })
        (import ../scripts/git-push-pr.nix { inherit pkgs; })

        # work
        powershell
        unstable.dotnet-sdk_8
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
        nil

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
  xdg.configFile."tealdeer/config.toml".source = ../nix-config/tealdeer/config.toml;
}
