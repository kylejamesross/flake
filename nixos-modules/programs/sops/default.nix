{
  inputs,
  user,
  ...
}: {
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  sops = {
    defaultSopsFile = ./secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "/home/${user}/.config/sops/age/keys.txt";
    secrets = {
      id_ed25519 = {owner = user;};
      openai_api_key = {owner = user;};
      github_token = {owner = user;};
      nextcloud_username = {owner = user;};
      nextcloud_password = {owner = user;};
    };
  };
}
