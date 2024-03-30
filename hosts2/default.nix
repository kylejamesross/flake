{ inputs, nixpkgs, ...}: 

let 
  user = "kyle";
  system = "x86_64-linux";
in 
{
  desktop = import ./desktop/configuration.nix {
    inherit inputs nixpkgs user system;
  };
  laptop = import ./laptop/configuration.nix {
    inherit inputs nixpkgs user system;
  };
}

