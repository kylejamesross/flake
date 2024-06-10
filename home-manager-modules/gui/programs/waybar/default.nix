{ config, ... }:


{
    programs.cava.enable = false;
    programs.waybar = {
        enable = false;
        systemd.enable = false;
        settings = import ./settings.nix {};
        style = import ./style.nix { inherit config; };
    };
}
