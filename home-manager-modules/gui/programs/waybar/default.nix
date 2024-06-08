{ config, ... }:


{
    programs.cava.enable = true;
    programs.waybar = {
        enable = true;
        systemd.enable = true;
        settings = import ./settings.nix {};
        style = import ./style.nix { inherit config; };
    };
}
