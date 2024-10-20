{
  description = "NixOS Flake Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/NUR";
    sops-nix.url = "github:Mic92/sops-nix";
    wallpapers = {
      url = "github:kylejamesross/wallpapers";
      flake = false;
    };
    stylix.url = "github:danth/stylix/release-24.05";
    nixvim = {
      url = "github:nix-community/nixvim/nixos-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ags = {
      url = "github:Aylur/ags";
    };
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
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
          ./hosts/x86_64-linux
          ./hosts/desktop
          ./nixos-modules
          inputs.stylix.nixosModules.stylix
          home-manager
          ./home-manager-modules
        ];
      };
      laptop = nixpkgs.lib.nixosSystem {
        inherit system specialArgs;
        modules = [
          ./hosts/x86_64-linux
          ./hosts/laptop
          ./nixos-modules
          inputs.stylix.nixosModules.stylix
          home-manager
          ./home-manager-modules
        ];
      };
      work = nixpkgs.lib.nixosSystem {
        inherit system specialArgs;
        modules = [
          ./nixos-modules/programs/stylix
          ./nixos-modules/programs/shell
          ./nixos-modules/programs/nh
          inputs.stylix.nixosModules.stylix
          home-manager
          inputs.nixos-wsl.nixosModules.default
          {
            system.stateVersion = "24.05";
            wsl.enable = true;
            networking.hostName = "work";
            users.users.${user} = {
              isNormalUser = true;
              extraGroups = [
                "wheel"
              ];
            };
          }
        ];
      };
    };
  };
}
