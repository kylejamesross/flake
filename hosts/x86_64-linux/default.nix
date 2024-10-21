{
  pkgs,
  inputs,
  user,
  lib,
  config,
  ...
}: let
  editor = pkgs.writeShellScriptBin "editor" ''
    FILENAME="/home/${user}/.cache/nvim/$(pwd | md5sum | awk '{ print $1 }').pipe"
    args=()
    for arg in "$@"; do
        if [ "$arg" != "--" ]; then
            args+=("$arg")
        fi
    done

    if [ -n "$TMUX" ]; then
        if tmux list-windows | grep -q ''; then
            tmux neww -S -n '' && nvim --server $FILENAME --remote "$args"
        else
            tmux neww -n '' nvim --listen $FILENAME "$args"
        fi
    else
        nvim --server $FILENAME --remote-silent "$args"
    fi
  '';
in {
  imports = [
    ./options
    ./bootloader
  ];

  users.users.${user} = {
    isNormalUser = true;
    extraGroups = ["wheel" "networkmanager" "docker"];
  };

  time.timeZone = "America/Edmonton";

  i18n.defaultLocale = "en_US.UTF-8";

  environment.variables = {
    TERMINAL = "kitty";
    EDITOR = ''${editor}/bin/editor '';
    VISUAL = "nvim";
    USERNAME = user;
    VSCODE_CODELLDB = "${pkgs.vscode-extensions.vadimcn.vscode-lldb}";
    DOTNET_ROOT = "${pkgs.dotnet-sdk}";
  };

  nix = {
    settings.auto-optimise-store = true;
    gc = {
      automatic = false;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
    package = pkgs.nixVersions.latest;
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

  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  security = {
    sudo.wheelNeedsPassword = false;
    rtkit.enable = true;
    polkit.enable = true;
    pam.services.swaylock = {
      text = ''
        auth include login
      '';
    };
  };

  fonts.packages = with pkgs; [
    carlito
    vegur
    source-code-pro
    jetbrains-mono
    font-awesome
    corefonts
    noto-fonts
    noto-fonts-emoji
    (nerdfonts.override {
      fonts = [
        "JetBrainsMono"
      ];
    })
  ];

  systemd = {
    extraConfig = "DefaultLimitNOFILE=65536";
    user.extraConfig = "DefaultLimitNOFILE=65536";
  };

  networking = {
    firewall.enable = false;
    networkmanager = {
      enable = true;
    };
  };

  virtualisation = {
    docker = {
      enable = false;
      liveRestore = false;
    };
    waydroid.enable = false;
  };

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };
}
