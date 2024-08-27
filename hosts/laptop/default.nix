{ ... }:

{
    imports = [
        ./hardware-configuration.nix
        ./config
    ];

    services.upower.enable = true;

    networking.hostName = "laptop";
}
