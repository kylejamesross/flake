{
  description = "NixOS Flake Configuration";

  inputs =
  {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/NUR";
    nix-colors.url = "github:misterio77/nix-colors";
    sops-nix.url = "github:Mic92/sops-nix";
  };

  outputs = { nixpkgs, self, ... }@inputs:
  let
    user = "kyle";
    system = "x86_64-linux";
    specialArgs = { inherit nixpkgs inputs user system; };
  in 
  {
    nixosConfigurations = {
      desktop = nixpkgs.lib.nixosSystem {
        inherit specialArgs;
        modules = [
          ./hosts2/desktop/configuration.nix
          ./home-manager-modules
          ./nixos-modules
        ];
      };
      laptop = nixpkgs.lib.nixosSystem {
        inherit specialArgs;
        modules = [
          ./hosts2/laptop/configuration.nix
          ./home-manager-modules
          ./nixos-modules
        ];
      };
    };
  };
}
