{
  pkgs,
  inputs,
  user,
  ...
}: {
  imports = [
    ./options
    ./bootloader
  ];

  users.users.${user} = {
    isNormalUser = true;
    extraGroups = ["wheel"];
  };

  time.timeZone = "America/Edmonton";

  i18n.defaultLocale = "en_US.UTF-8";

  environment.variables = {
    TERMINAL = "kitty";
    EDITOR = "nvim";
    VISUAL = "nvim";
    USERNAME = user;
    AICHAT_PLATFORM = "claude";
  };

  nix = {
    settings.auto-optimise-store = true;
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
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
}
