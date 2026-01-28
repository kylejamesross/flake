{
  nixpkgs,
  inputs,
  user,
  unstable,
  system,
  oldPkgs,
  ...
}: {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {
      inherit nixpkgs inputs user unstable system oldPkgs;
    };
    users.${user} = {
      imports = [
        ./home
        ./gui
        ./terminal
        ./stylix
        inputs.nixvim.homeModules.nixvim
      ];
    };
  };
}
