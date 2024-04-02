{ inputs, user, ... }:

{
    imports = [
        inputs.sops-nix.nixosModules.sops
    ];

    sops = {
        defaultSopsFile = ./secrets.yaml;
        defaultSopsFormat = "yaml";
        age.keyFile = "/home/${user}/.config/sops/age/keys.txt";
        secrets = {
            work_npmrc = { owner = user; };
            id_ed25519 = { owner = user; };
            feed_access_token = { owner = user; };
            openai_api_key = { owner = user; };
        };
    };
}
