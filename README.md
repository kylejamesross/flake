# flake

This repository houses my Nix configuration files for setting up my operating system. This encompasses not only the configuration of various applications but also includes any additional app plugins that I use.

## Installation Steps

### Desktop
1. git clone https://github.com/kylejamesross/flake.git
2. sudo nixos-generate-config --root /mnt
3. cp /mnt/etc/nixos/hardware-configuration.nix /mnt/flake/hosts/desktop/hardware-configuration.nix
4. sudo rm /mnt/etc/nixos/configuration.nix
5. sudo nixos-install --flake .#desktop

### Laptop
1. git clone https://github.com/kylejamesross/flake.git
2. sudo nixos-generate-config --root /mnt
3. cp /mnt/etc/nixos/hardware-configuration.nix /mnt/flake/hosts/laptop/hardware-configuration.nix
4. sudo rm /mnt/etc/nixos/configuration.nix
5. sudo nixos-install --flake .#laptop

### Setup secrets key
1. mkdir -p ~/.config/sops/age/
2. wl-paste >> ~/.config/sops/age/keys.txt
