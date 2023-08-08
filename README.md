# .dotfiles

This repository houses my Nix configuration files for setting up my operating system. This encompasses not only the configuration of various applications but also includes any additional app plugins that I use.

## Installation Steps

### Desktop
1. sudo nixos-generate-config --root /mnt
2. cp /mnt/etc/nixos/hardware-configuration.nix /mnt/flake/hosts/desktop/
3. sudo rm /mnt/etc/nixos/configuration.nix
4. sudo nixos-install --flake .#desktop

### Laptop
1. sudo nixos-generate-config --root /mnt
2. cp /mnt/etc/nixos/hardware-configuration.nix /mnt/flake/hosts/laptop/
3. sudo rm /mnt/etc/nixos/configuration.nix
4. sudo nixos-install --flake .#laptop

### Post-installation
1. ansible-playbook --ask-become-pass install-workplace.yml
2. ansible-playbook --ask-vault-pass install-secrets.yml
