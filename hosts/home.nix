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
      unstable.eza
      bat
      du-dust
      nodejs
      unstable.bun
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
  xdg.configFile."kitty/kitty.conf".source = ../nix-config/kitty/kitty.conf;
  xdg.configFile."lazygit/config.yml".source = ../nix-config/lazygit/config.yml;
  xdg.configFile."mako/config".source = ../nix-config/mako/config;
  xdg.configFile."swappy/config".source = ../nix-config/swappy/config;
  xdg.configFile."swaylock/config".source = ../nix-config/swaylock/config;
  xdg.configFile."waybar/config.jsonc".source = ../nix-config/waybar/config.jsonc;
  xdg.configFile."waybar/style.css".source = ../nix-config/waybar/style.css;
  xdg.configFile."waybar/nix-snowflake.svg".source = ../nix-config/waybar/nix-snowflake.svg;
  xdg.configFile."wlogout/hibernate.png".source = ../nix-config/wlogout/hibernate.png;
  xdg.configFile."wlogout/lock.png".source = ../nix-config/wlogout/lock.png;
  xdg.configFile."wlogout/logout.png".source = ../nix-config/wlogout/logout.png;
  xdg.configFile."wlogout/reboot.png".source = ../nix-config/wlogout/reboot.png;
  xdg.configFile."wlogout/shutdown.png".source = ../nix-config/wlogout/shutdown.png;
  xdg.configFile."wlogout/suspend.png".source = ../nix-config/wlogout/suspend.png;
  xdg.configFile."wlogout/style.css".source = ../nix-config/wlogout/style.css;
  home.file.".face".source = ../nix-config/.face;
  home.file.".p10k.zsh".source = ../nix-config/.p10k.zsh;
  home.file.".zshrc".source = ../nix-config/.zshrc;
  home.file.".mozilla/firefox/kyle/chrome/dracula".source = inputs.firefox-dracula-theme;
  xdg.configFile."nvim" = {
    source = ../nix-config/nvim;
    recursive = true;
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "application/pdf" = "okularApplication_pdf.desktop";
      "image/svg+xml" = "org.inkscape.Inkscape.desktop";
      "image/png" = "swappy.desktop";
      "image/jpeg" = "swappy.desktop";
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
      "application/x-extension-htm" = "firefox.desktop";
      "application/x-extension-html" = "firefox.desktop";
      "application/x-extension-shtml" = "firefox.desktop";
      "application/xhtml+xml" = "firefox.desktop";
      "application/x-extension-xhtml" = "firefox.desktop";
      "application/x-extension-xht" = "firefox.desktop";
      "text/html" = "firefox.desktop";
      "x-scheme-handler/chrome" = "firefox.desktop";
      "text/plain" = "notepadqq.desktop";
    };
  };
}
