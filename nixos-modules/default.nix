{pkgs, ...}: {
  imports = [
    ./programs/stylix
    ./programs/sops
    ./programs/steam
    ./programs/shell
    ./programs/hyprland
    ./programs/nh
    ./programs/vm

    ./services/printing
    ./services/secrets
    ./services/keyd
    ./services/pipewire
    ./services/greetd
    ./services/nextcloud-autosync
  ];

  services = {
    ollama = {
      enable = true;
      acceleration = "rocm";
      loadModels = [
        "deepseek-r1:1.5b"
      ];
    };
    open-webui.enable = true;
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
  ];
}
