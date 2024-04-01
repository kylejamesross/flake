{ pkgs, user, ... }:

{
    systemd.user = {
        services.nextcloud-autosync = {
            Unit = {
                Description = "Auto sync Nextcloud";
                After = [ "network-online.target" ];
            };
            Service = {
                Type = "simple";
                ExecStart = "${pkgs.nextcloud-client}/bin/nextcloudcmd -h -n --path / /home/${user}/nextcloud https://nextcloud.kylejamesross.com";
                TimeoutStopSec = "180";
                KillMode = "process";
                KillSignal = "SIGINT";
            };
            Install.WantedBy = [ "default.target" ];
        };
        timers.nextcloud-autosync = {
            Unit.Description = "Automatic sync files with Nextcloud when booted up after 5 minutes then rerun every 60 minutes";
            Timer = {
                OnBootSec = "5min";
                OnUnitActiveSec = "60min";
            };
            Install.WantedBy = [ "default.target" "timers.target" ];
        };
    };
}
