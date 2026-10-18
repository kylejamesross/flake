{
  config,
  pkgs,
  user,
  ...
}: let
  home = config.users.users.${user}.home;
in {
  systemd.services.secret-service = {
    description = "Materialise sops-managed user secrets";
    wantedBy = ["default.target"];
    after = ["sops-install-secrets.service"];
    requires = ["sops-install-secrets.service"];
    script = ''
      ${pkgs.coreutils}/bin/install -d -m 700 "${home}/.ssh"

      ${pkgs.coreutils}/bin/install -m 600 ${config.sops.secrets.id_ed25519.path} "${home}/.ssh/id_ed25519"
      ${pkgs.coreutils}/bin/install -m 600 ${config.sops.secrets.openai_api_key.path} "${home}/.openai-api-key"
      ${pkgs.coreutils}/bin/install -m 600 ${config.sops.secrets.anthropic_api_key.path} "${home}/.anthropic_api_key"
      ${pkgs.coreutils}/bin/install -m 600 ${config.sops.secrets.deepseek_api_key.path} "${home}/.deepseek_api_key"
      ${pkgs.coreutils}/bin/install -m 600 ${config.sops.secrets.github_token.path} "${home}/.github-token"
      ${pkgs.coreutils}/bin/install -m 600 ${config.sops.secrets.work_azure_devops_pull_request_token.path} "${home}/.work_azure_devops_pull_request_token"
    '';
    serviceConfig = {
      Type = "oneshot";
      User = user;
      WorkingDirectory = home;
      UMask = "0077";
    };
  };
}
