{ config, user, ...}:

{
    systemd.services."secret-service" = {
        script = ''
            echo "$(cat ${config.sops.secrets.work_npmrc.path})" > /home/${user}/.npmrc
            mkdir -p /home/${user}/.ssh/
            echo "$(cat ${config.sops.secrets.id_ed25519.path})" > /home/${user}/.ssh/id_ed25519
            chmod 600 /home/${user}/.ssh/id_ed25519
            chmod 700 /home/${user}/.ssh/
            chmod 644 /home/${user}/.ssh/id_ed25519.pub
            chmod 644 /home/${user}/.ssh/authorized_keys
            echo "$(cat ${config.sops.secrets.feed_access_token.path})" > /home/${user}/.feed-access-token
            echo "$(cat ${config.sops.secrets.openai_api_key.path})" > /home/${user}/.openai-api-key
            echo "$(cat ${config.sops.secrets.nextcloud_netrc.path})" > /home/${user}/.netrc
            mkdir -p /home/${user}/nextcloud
        '';
        serviceConfig = {
            User = user;
            WorkingDirectory = "/home/${user}/";
        };
        wantedBy = ["default.target"];
    };
}
