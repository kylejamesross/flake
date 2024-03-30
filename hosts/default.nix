#
#  These are the different profiles that can be used when building NixOS.
#

{ inputs, nixpkgs, user, ... }:

let
  system = "x86_64-linux";

  unstable = import inputs.nixpkgs-unstable {
    inherit system;
    config.allowUnfree = true;
  };

  lib = nixpkgs.lib;

  nix-colors = inputs.nix-colors;

  nur = inputs.nur;

  home-manager = inputs.home-manager;

in
{
  desktop = lib.nixosSystem {
    inherit system;
    specialArgs = {
      inherit inputs unstable system user nix-colors;
      host = {
        hostName = "desktop";
      };
    };
    modules = [
      ./common
      ./desktop
      ./configuration.nix

      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = {
        inherit inputs unstable user nix-colors system;
          host = {
            hostName = "desktop";
          };
        };
        home-manager.users.${user} = {
          imports = [
            nix-colors.homeManagerModules.default
            nur.nixosModules.nur
            ./home.nix
            ./common/home.nix
            ./desktop/home.nix
          ];
        };
      }
    ];
  };
  laptop = lib.nixosSystem {
    inherit system;
    specialArgs = {
      inherit inputs unstable system user nix-colors;
      host = {
        hostName = "laptop";
      };
    };
    modules = [
      nur.nixosModules.nur
      ./common
      ./laptop
      ./configuration.nix

      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = {
          inherit inputs unstable user nix-colors;
          host = {
            hostName = "laptop";
          };
        };
        home-manager.users.${user} = {
          imports = [
            nix-colors.homeManagerModules.default
            nur.nixosModules.nur
            ./home.nix
            ./common/home.nix
          ];
        };
      }
    ];
  };
}
