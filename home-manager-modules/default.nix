{
  nixpkgs,
  inputs,
  user,
  unstable,
  system,
  ...
}: {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {
      inherit nixpkgs inputs user unstable system;
    };
    users.${user} = {
      imports = [
        ./home
        ./gui
        ./terminal
        ./stylix
        inputs.nixvim.homeManagerModules.nixvim
      ];
    };
  };
}
