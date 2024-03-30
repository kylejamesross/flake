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

outputs =  { self, nixpkgs, ... }@inputs:
    let
      user = "kyle";
    in
    {
      nixosConfigurations = (
        import ./hosts {
          inherit nixpkgs;
          inherit inputs;
          inherit user;
        }
      );
    };
}
