{inputs, ...}: {
  flake.homeConfigurations = {
    kyle = inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = import inputs.nixpkgs {system = "x86_64-linux";};
      modules = [../home-manager-modules];
    };
  };
}
