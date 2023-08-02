{
  description = "My Personal NixOS and Darwin System Flake Configuration";

  inputs =
    {
      nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
      nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

      home-manager = {
        url = "github:nix-community/home-manager/release-23.05";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      nur = {
        url = "github:nix-community/NUR";
      };

      hyprland.url = "github:hyprwm/Hyprland";
    };

  outputs = inputs @ { self, nixpkgs, nixpkgs-unstable, home-manager, nur, hyprland, ... }:
    let
      user = "kyle";
    in
    {
      nixosConfigurations = (
        import ./hosts {
          inherit (nixpkgs) lib;
          inherit inputs nixpkgs nixpkgs-unstable home-manager nur user hyprland;
        }
      );
    };
}
