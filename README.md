# .dotfiles

This repository contains the necessary configuration files and instructions to set up NixOS on your laptop and desktop using the flake-based approach. With the provided instructions and configuration files, you can easily deploy a NixOS system tailored to your needs on both your laptop and desktop.

## Installation Steps

### Desktop
1. sudo nixos-generate-config --root /mnt
2. cp -r /mnt/etc/nixos /mnt/flake/hosts/desktop
3. sudo rm /mnt/etc/nixos/configuration.nix
4. sudo nixos-install --flake .#desktop

### Laptop
1. sudo nixos-generate-config --root /mnt
2. cp -r /mnt/etc/nixos /mnt/flake/hosts/laptop
3. sudo rm /mnt/etc/nixos/configuration.nix
4. sudo nixos-install --flake .#laptop

### Post-installation
1. ansible-playbook --ask-become-pass install-workplace.yml
2. ansible-playbook --ask-vault-pass install-secrets.yml
