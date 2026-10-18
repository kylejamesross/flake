{
  pkgs,
  config,
  user,
  ...
}: let
  home = config.users.users.${user}.home;
in {
  systemd.services.nextcloud-autosync = {
    description = "Auto sync Nextcloud";
    after = [
      "network-online.target"
      "sops-install-secrets.service"
    ];
    wants = ["network-online.target"];
    requires = ["sops-install-secrets.service"];
    path = [
      pkgs.coreutils
      pkgs.nextcloud-client
    ];
    script = ''
      mkdir -p "${home}/notes"
      export NC_USER="$(cat ${config.sops.secrets.nextcloud_username.path})"
      export NC_PASSWORD="$(cat ${config.sops.secrets.nextcloud_password.path})"
      nextcloudcmd \
        --non-interactive \
        --trust \
        --path /Notes \
        "${home}/notes" \
        https://nextcloud.kylejamesross.com
    '';
    serviceConfig = {
      Type = "oneshot";
      User = user;
      WorkingDirectory = home;
      UMask = "0077";
    };
  };

  systemd.timers.nextcloud-autosync = {
    description = "Sync files with Nextcloud every 5 minutes";
    timerConfig = {
      OnCalendar = "*:0/5";
      Persistent = true;
      Unit = "nextcloud-autosync.service";
    };
    wantedBy = ["timers.target"];
  };
}
