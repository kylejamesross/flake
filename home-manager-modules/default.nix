{
  nixpkgs,
  inputs,
  user,
  unstable,
  system,
  oldPkgs,
  theme,
  ...
}: {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "bak";
    extraSpecialArgs = {
      inherit nixpkgs inputs user unstable system oldPkgs theme;
    };
    users.${user} = {
      imports = [
        ./home
        ./gui
        ./terminal
        ./stylix
        ./colors
        inputs.nixvim.homeModules.nixvim
      ];
    };
  };
}
