{
  pkgs,
  config,
  ...
}: {
  imports = [
    ./programs/hyprland
    ./programs/nh
    ./programs/shell
    ./programs/sops
    ./programs/steam
    ./programs/stylix
    ./programs/vm

    ./services/greetd
    ./services/keyd
    ./services/nextcloud-autosync
    ./services/ollama
    ./services/pipewire
    ./services/printing
    ./services/secrets
  ];

  services = {
    open-webui.enable = config.ollama.enable;
  };

  programs = {
    dconf.enable = true;
    git.enable = true;
  };

  environment.systemPackages = with pkgs; [
    bash
    xdg-utils
    inetutils
    cifs-utils
    gpclient
    remmina
  ];
}
