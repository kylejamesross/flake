{
  description = "My Personal NixOS and Darwin System Flake Configuration";

  inputs =
    {
      nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
      nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

      home-manager = {
        url = "github:nix-community/home-manager/release-23.11";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      hyprland = {
        url = "github:hyprwm/Hyprland";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      nur.url = "github:nix-community/NUR";

      nix-colors.url = "github:misterio77/nix-colors";
    };

  outputs = inputs @ { self, nixpkgs, nixpkgs-unstable, home-manager, nur, nix-colors, hyprland, ... }:
    let
      user = "kyle";
    in
    {
      nixosConfigurations = (
        import ./hosts {
          inherit (nixpkgs) lib;
          inherit inputs nixpkgs nixpkgs-unstable home-manager nur user nix-colors hyprland;
        }
      );
    };
}
