{
  config,
  lib,
  user,
  ...
}: let
  home = config.users.users.${user}.home;

  userCredentials = {
    openai_api_key = ".openai_api_key";
    anthropic_api_key = ".anthropic_api_key";
    deepseek_api_key = ".deepseek_api_key";
    github_token = ".github_token";
    work_azure_devops_pull_request_token = ".work_azure_devops_pull_request_token";
  };

  credentialScript = lib.concatStrings (
    lib.mapAttrsToList (
      secret: target: ''
        install -m 600 ${config.sops.secrets.${secret}.path} ${
          lib.escapeShellArg "${home}/${target}"
        }
      ''
    )
    userCredentials
  );
in {
  systemd.services.user-secrets = {
    description = "Materialise sops-managed user secrets into ${home}";
    wantedBy = ["default.target"];

    restartTriggers = lib.unique (
      lib.mapAttrsToList (_: secret: secret.sopsFileHash) config.sops.secrets
    );

    script =
      ''
        install -d -m 700 ${lib.escapeShellArg "${home}/.ssh"}
        install -m 600 ${config.sops.secrets.id_ed25519.path} ${
          lib.escapeShellArg "${home}/.ssh/id_ed25519"
        }
      ''
      + credentialScript;

    serviceConfig = {
      Type = "oneshot";
      User = user;
      WorkingDirectory = home;
      UMask = "0077";
    };
  };
}
