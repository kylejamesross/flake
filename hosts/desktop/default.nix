{ ... }:

{
    imports = [
        ./hardware-configuration.nix
    ];

    boot.initrd.kernelModules = [ "amdgpu" ];
}
