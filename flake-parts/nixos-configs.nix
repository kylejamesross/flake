{inputs, ...}: {
  flake.nixosConfigurations = let
    user = "kyle";
    system = "x86_64-linux";
    unstable = import inputs.nixpkgs-unstable {
      inherit system;
      config.allowUnfree = true;
    };
    specialArgs = {inherit inputs system user unstable;};
    home-manager = inputs.home-manager.nixosModules.home-manager;

    commonModules = [
      ../hosts/x86_64-linux
      ../nixos-modules
      inputs.stylix.nixosModules.stylix
      inputs.nur.modules.nixos.default
      home-manager
      ../home-manager-modules
    ];

    mkHost = hostPath: extraModules:
      inputs.nixpkgs.lib.nixosSystem {
        inherit system specialArgs;
        modules = [hostPath] ++ commonModules ++ extraModules;
      };
  in {
    desktop = mkHost ../hosts/desktop [];
    laptop = mkHost ../hosts/laptop [];
    wsl = mkHost ../hosts/wsl [inputs.nixos-wsl.nixosModules.wsl];
  };
}
