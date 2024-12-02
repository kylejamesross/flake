{
  description = "NixOS Flake Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/NUR";
    sops-nix.url = "github:Mic92/sops-nix";
    wallpapers = {
      url = "github:kylejamesross/wallpapers";
      flake = false;
    };
    stylix.url = "github:danth/stylix";
    nixvim = {
      url = "github:nix-community/nixvim/nixos-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ags = {
      url = "github:Aylur/ags";
    };
    nixos-wsl.url = "github:nix-community/NixOS-WSL";
  };

  outputs = {
    nixpkgs,
    nixpkgs-unstable,
    self,
    ...
  } @ inputs: let
    user = "kyle";
    system = "x86_64-linux";
    unstable = import nixpkgs-unstable {
      inherit system;
      config.allowUnfree = true;
    };
    specialArgs = {inherit nixpkgs inputs user unstable;};
    home-manager = inputs.home-manager.nixosModules.home-manager;
  in {
    nixosConfigurations = {
      inherit specialArgs;
      desktop = nixpkgs.lib.nixosSystem {
        inherit system specialArgs;
        modules = [
          ./hosts/desktop
          ./hosts/x86_64-linux
          ./nixos-modules
          inputs.stylix.nixosModules.stylix
          home-manager
          ./home-manager-modules
        ];
      };
      laptop = nixpkgs.lib.nixosSystem {
        inherit system specialArgs;
        modules = [
          ./hosts/laptop
          ./hosts/x86_64-linux
          ./nixos-modules
          inputs.stylix.nixosModules.stylix
          home-manager
          ./home-manager-modules
        ];
      };
      wsl = nixpkgs.lib.nixosSystem {
        inherit system specialArgs;
        modules = [
          ./hosts/wsl
          ./hosts/x86_64-linux
          inputs.stylix.nixosModules.stylix
          inputs.nixos-wsl.nixosModules.wsl
          ./nixos-modules
          home-manager
          ./home-manager-modules
        ];
      };
    };
  };
}
