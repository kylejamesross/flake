#
#  Main system configuration. More information available in configuration.nix(5) man page.
#

{ config, pkgs, inputs, user, ... }:

{
  imports = [
    ../modules/shell/zsh.nix
    inputs.sops-nix.nixosModules.sops
  ];

  sops = {
    defaultSopsFile = ../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "/home/${user}/.config/sops/age/keys.txt";
  };
  sops.secrets = {
    work_npmrc = { owner = user; };
    id_ed25519 = { owner = user; };
    feed_access_token = { owner = user; };
    openai_api_key = { owner = user; };
  };

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
      BAT_THEME = "base16-256";
      USERNAME = user;
      VSCODE_CODELLDB = "${pkgs.vscode-extensions.vadimcn.vscode-lldb}";
      DOTNET_ROOT = "${pkgs.dotnet-sdk}";
    };
    systemPackages = with pkgs; [
      git
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
    stateVersion = "22.05";
  };

  systemd.extraConfig = ''
    DefaultLimitNOFILE=65536
  '';
  systemd.user.extraConfig = ''
    DefaultLimitNOFILE=65536
  '';
  systemd.services."secret-service" = {
    script = ''
        echo "$(cat ${config.sops.secrets.work_npmrc.path})" > /home/${user}/.npmrc
        mkdir -p /home/${user}/.ssh/
        echo "$(cat ${config.sops.secrets.id_ed25519.path})" > /home/${user}/.ssh/id_ed25519
        chmod 600 /home/${user}/.ssh/id_ed25519
        echo "$(cat ${config.sops.secrets.feed_access_token.path})" > /home/${user}/.feed-access-token
        echo "$(cat ${config.sops.secrets.openai_api_key.path})" > /home/${user}/.openai-api-key
      '';
    serviceConfig = {
      User = user;
      WorkingDirectory = "/home/${user}/";
    };
    wantedBy = ["default.target"];
  };
}
