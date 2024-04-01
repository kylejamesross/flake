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

    outputs = { nixpkgs, nixpkgs-unstable, self, ... }@inputs:
        let user = "kyle";
        system = "x86_64-linux";
        unstable = import nixpkgs-unstable {
            inherit system;
            config.allowUnfree = true;
        };
        home-manager = inputs.home-manager.nixosModules.home-manager;
    in 
    {
        nixosConfigurations = {
            desktop = nixpkgs.lib.nixosSystem {
                inherit system;
                specialArgs = { 
                    inherit nixpkgs inputs user unstable; 
                    hostName = "desktop";
                };
                modules = [
                    ./hosts/x86_64-linux
                    ./hosts/desktop
                    ./nixos-modules
                    home-manager 
                    ./home-manager-modules
                ];
            };
            laptop = nixpkgs.lib.nixosSystem {
                inherit system;
                specialArgs = { 
                    inherit nixpkgs inputs user unstable; 
                    hostName = "laptop";
                };
                modules = [
                    ./hosts/x86_64-linux
                    ./hosts/laptop
                    ./nixos-modules
                    home-manager 
                    ./home-manager-modules
                ];
            };
        };
    };
}
