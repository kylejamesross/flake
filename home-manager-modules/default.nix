{
  nixpkgs,
  inputs,
  user,
  unstable,
  ...
}: {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {
      inherit nixpkgs inputs user unstable;
    };
    users.${user} = {
      imports = [
        ./home
        ./gui
        ./terminal
        ./stylix
        inputs.nixvim.homeManagerModules.nixvim
        inputs.ags.homeManagerModules.default
      ];
    };
  };
}
