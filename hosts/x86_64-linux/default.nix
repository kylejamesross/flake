{ pkgs, inputs, user, ... }:

{
    imports = [
        ./options
    ];

    users.users.${user} = {
        isNormalUser = true;
        extraGroups = [ "wheel" "networkmanager" "docker" ];
    };

    time.timeZone = "America/Edmonton";

    i18n.defaultLocale = "en_US.UTF-8";

    environment.variables = {
        TERMINAL = "kitty";
        EDITOR = "nvim";
        VISUAL = "nvim";
        BAT_THEME = "base16-256";
        USERNAME = user;
        VSCODE_CODELLDB = "${pkgs.vscode-extensions.vadimcn.vscode-lldb}";
        DOTNET_ROOT = "${pkgs.dotnet-sdk}";
    };

    nix = {
        settings.auto-optimise-store = true;
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

    boot = {
        kernelPackages = pkgs.linuxPackages_latest;
        loader = {
            systemd-boot = {
                enable = true;
                configurationLimit = 20;
            };
            efi.canTouchEfiVariables = true;
            timeout = 1;
        };
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
        watchdog.rebootTime = "5s";
        extraConfig = "DefaultLimitNOFILE=65536";
        user.extraConfig = "DefaultLimitNOFILE=65536";
    };

    networking = {
        firewall.enable = false;
        networkmanager = {
            enable = true;
        };
    };

    virtualisation.docker.enable = true;

    hardware.opengl = {
        enable = true;
        driSupport = true;
        driSupport32Bit = true;
    };
}
