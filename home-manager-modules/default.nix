{
  nixpkgs,
  inputs,
  user,
  system,
  theme,
  ...
}: {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "bak";
    extraSpecialArgs = {
      inherit nixpkgs inputs user system theme;
    };
    users.${user} = {
      imports = [
        ./home
        ./gui
        ./terminal
        ./stylix
        ./colors
        inputs.nixvim.homeModules.default
      ];
    };
  };
}
