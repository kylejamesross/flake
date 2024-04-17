{ ... }:

{
    imports = [
        ./hardware-configuration.nix
        ./config
    ];

    networking.hostName = "laptop";
}
