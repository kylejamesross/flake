{ ... }:

{
    imports = [
        ./hardware-configuration.nix
        ./config
    ];

    boot.initrd.kernelModules = [ "amdgpu" ];
}
