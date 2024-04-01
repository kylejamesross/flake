{ nixpkgs, inputs, user, hostName, unstable, ...}: 

{
    home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = {
            inherit nixpkgs inputs user hostName unstable;
        };
        users.${user} = {
            imports = [
                ./home.nix
                ./gui.nix
                ./terminal.nix
                inputs.nix-colors.homeManagerModules.default
                inputs.nur.hmModules.nur
            ];
        };
    };
}
