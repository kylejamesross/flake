# flake

NixOS, Home Manager, and WSL configuration for Kyle's machines. The flake uses
`flake-parts` and keeps host-specific settings under `hosts/`, with reusable
NixOS and Home Manager modules in `nixos-modules/` and `home-manager-modules/`.

## Hosts

| Host | Purpose | Notes |
| --- | --- | --- |
| `desktop` | Main desktop | Hyprland, AGS, Steam, Sunshine, VMs |
| `laptop` | Laptop | Hyprland, AGS |
| `wsl` | Windows Subsystem for Linux | Terminal-only, no GUI services |
| `kyle` | Standalone Home Manager output | Terminal modules only |

Rebuild a NixOS host from the repository root:

```sh
sudo nixos-rebuild switch --flake .#desktop
sudo nixos-rebuild switch --flake .#laptop
sudo nixos-rebuild switch --flake .#wsl
```

The configured helper `g` runs `nh os switch "$HOME/flake"`.

Optional standalone Home Manager switch:

```sh
home-manager switch --flake .#kyle
```

## Fresh installation

### Desktop or laptop

1. Clone the repository.
2. Generate hardware configuration:

   ```sh
   sudo nixos-generate-config --root /mnt
   cp /mnt/etc/nixos/hardware-configuration.nix \
     /mnt/flake/hosts/<host>/hardware-configuration.nix
   ```

3. Install:

   ```sh
   sudo nixos-install --flake /mnt/flake#<host>
   ```

4. After the first boot, move the repository to `~/flake`, fix ownership, and
   set the user password:

   ```sh
   mv /flake "$HOME/flake"
   sudo chown -R kyle:kyle "$HOME/flake"
   passwd kyle
   ```

### WSL

Enable WSL integration in Windows, install NixOS-WSL, then switch to the `wsl`
host from inside the WSL instance:

```sh
sudo nixos-rebuild switch --flake .#wsl
```

The WSL host explicitly disables GUI, Hyprland, AGS, keyd, Steam, Sunshine, and
virtualisation modules.

## Secrets

Secrets are managed with `sops-nix` and the age key at
`~/.config/sops/age/keys.txt`. On a new machine, restore that key first:

```sh
mkdir -p "$HOME/.config/sops/age"
wl-paste > "$HOME/.config/sops/age/keys.txt"
chmod 600 "$HOME/.config/sops/age/keys.txt"
```

Encrypted secrets live in `nixos-modules/programs/sops/secrets.yaml`. The
`secret-service` systemd unit materialises the user-facing credential files with
mode `0600`.

## Flatpak

The Flathub remote is configured by NixOS. Individual Flatpak applications are
installed manually because NixOS has no declarative package option for them:

```sh
flatpak install flathub org.inkscape.Inkscape
flatpak install flathub io.github.flattool.Warehouse
flatpak install flathub io.dbeaver.DBeaverCommunity
```

## Development

Format and lint the repository:

```sh
nix fmt
nix flake check --no-build
nix build .#checks.x86_64-linux.statix --no-link
nix build .#checks.x86_64-linux.deadnix --no-link
```

Evaluate all hosts without building them:

```sh
for host in desktop laptop wsl; do
  nix eval ".#nixosConfigurations.${host}.config.system.build.toplevel.drvPath"
done
```

## Architecture

```text
flake.nix
  -> flake-parts/nixos-configs.nix  # desktop, laptop, wsl
     -> hosts/<host>                # hardware + host feature flags
     -> nixos-modules/              # reusable system modules
     -> home-manager-modules/       # user environment
  -> flake-parts/home-manager.nix   # standalone kyle home configuration
  -> flake-parts/dev.nix            # formatter + lint checks
```

Host features use the `my.*` option namespace, for example
`my.gui.enable`, `my.hyprland.enable`, `my.steam.enable`, and
`my.vm.enable`. This keeps host toggles separate from upstream NixOS options.
