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
                inputs.nur.hmModules.nur
            ];
        };
    };
}
