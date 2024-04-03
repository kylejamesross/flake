{ nixpkgs, inputs, user, unstable, ...}: 

{
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
                inputs.nix-colors.homeManagerModules.default
                inputs.nur.hmModules.nur
            ];
        };
    };
}
