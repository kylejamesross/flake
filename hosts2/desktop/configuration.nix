{ inputs, nixpkgs, user, system ... }:

nixpkgs.lib.nixosSytem {
  specialArgs = { inherit inputs nixpkgs user system; };
};
