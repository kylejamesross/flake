{inputs, ...}: let
  system = "x86_64-linux";
  user = "kyle";
  theme = "cerulean-signal-dark";
  pkgs = import inputs.nixpkgs {
    inherit system;
    config.allowUnfree = true;
    overlays = [
      (_final: _prev: {
        inherit (unstable) pi-coding-agent;
      })
    ];
  };
  unstable = import inputs.nixpkgs-unstable {
    inherit system;
    config.allowUnfree = true;
  };
in {
  flake.homeConfigurations.${user} = inputs.home-manager.lib.homeManagerConfiguration {
    inherit pkgs;
    modules = [
      inputs.stylix.homeModules.stylix
      inputs.nixvim.homeModules.default
      ../home-manager-modules/home
      ../home-manager-modules/terminal
      ../home-manager-modules/stylix
      ../home-manager-modules/colors
      {
        home.homeDirectory = "/home/${user}";
        stylix = {
          enable = true;
          base16Scheme = "${inputs.tinted-schemes}/base16/${theme}.yaml";
          image = ../static/wallpaper.png;
        };
      }
    ];
    extraSpecialArgs = {
      inherit inputs system user theme;
    };
  };
}
