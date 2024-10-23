{
  pkgs,
  config,
  user,
  ...
}: {
  systemd.services.nextcloud-autosync = {
    script = ''
      mkdir -p /home/${user}/notes/
      ${pkgs.nextcloud-client}/bin/nextcloudcmd -u $(cat ${config.sops.secrets.nextcloud_username.path}) -p $(cat ${config.sops.secrets.nextcloud_password.path}) --path /Notes /home/kyle/notes https://nextcloud.kylejamesross.com
    '';
    description = "Auto sync Nextcloud";
    after = ["network-online.target"];
    wants = ["network-online.target"];
    serviceConfig = {
      User = user;
      WorkingDirectory = "/home/${user}/";
    };
    wantedBy = ["default.target"];
  };

  systemd.timers.nextcloud-autosync = {
    description = "Automatic sync files with Nextcloud when booted up after 5 minutes then rerun every 5 minutes";
    timerConfig = {
      OnUnitActiveSec = "5min";
      OnBootSec = "5min";
      Unit = "nextcloud-autosync.service";
    };
    wantedBy = ["default.target" "timers.target"];
  };
}
