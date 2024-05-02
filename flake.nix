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
        wallpapers = {
            url = "github:kylejamesross/wallpapers";
            flake = false;
        };
        nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    };

    outputs = { nixpkgs, nixpkgs-unstable, self, nixos-hardware, ... }@inputs:
        let user = "kyle";
        system = "x86_64-linux";
        unstable = import nixpkgs-unstable {
            inherit system;
            config.allowUnfree = true;
        };
        specialArgs = { inherit nixpkgs inputs user unstable; };
        home-manager = inputs.home-manager.nixosModules.home-manager;
    in 
    {
        nixosConfigurations = {
            inherit specialArgs;
            desktop = nixpkgs.lib.nixosSystem {
                inherit system specialArgs;
                modules = [
                    ./hosts/x86_64-linux
                    ./hosts/desktop
                    ./nixos-modules
                    home-manager 
                    ./home-manager-modules
                ];
            };
            laptop = nixpkgs.lib.nixosSystem {
                inherit system specialArgs;
                modules = [
                    ./hosts/x86_64-linux
                    nixos-hardware.nixosModules.lenovo-thinkpad-x1-extreme-gen2
                    ./hosts/laptop
                    ./nixos-modules
                    home-manager 
                    ./home-manager-modules
                ];
            };
        };
    };
}
