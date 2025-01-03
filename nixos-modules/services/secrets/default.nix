{
  config,
  user,
  ...
}: {
  systemd.services."secret-service" = {
    script = ''
      echo "$(cat ${config.sops.secrets.id_ed25519.path})" > /home/${user}/.ssh/id_ed25519
      [ -f /home/${user}/.ssh/id_ed25519 ] && chmod 600 /home/${user}/.ssh/id_ed25519
      [ -d /home/${user}/.ssh/ ] && chmod 700 /home/${user}/.ssh/
      echo "$(cat ${config.sops.secrets.openai_api_key.path})" > /home/${user}/.openai-api-key
      echo "$(cat ${config.sops.secrets.anthropic_api_key.path})" > /home/${user}/.anthropic_api_key
      echo "$(cat ${config.sops.secrets.github_token.path})" > /home/${user}/.github-token
      echo "$(cat ${config.sops.secrets.work_azure_devops_pull_request_token.path})" > /home/${user}/.work_azure_devops_pull_request_token
    '';
    serviceConfig = {
      User = user;
      WorkingDirectory = "/home/${user}/";
    };
    wantedBy = ["default.target"];
  };
}
