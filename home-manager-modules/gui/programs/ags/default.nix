{
  inputs,
  pkgs,
  system,
  ...
}: let
  ags-widgets = inputs.ags.lib.bundle {
    inherit pkgs;
    name = "ags-widgets";
    src = ./.;
    entry = "app.ts";

    extraPackages = with inputs.astal.packages.${system}; [
      astal3
      io
      apps
      battery
      hyprland
      mpris
      notifd
      powerprofiles
      wireplumber
      network
      tray
      inputs.ags.packages.${system}.default
      pkgs.wrapGAppsHook
      pkgs.gobject-introspection
    ];
  };
in {
  home.packages = with pkgs; [
    ags-widgets
    dart-sass
  ];

  systemd.user.services.ags = {
    Unit = {
      Description = "Aylur's GTK Shell";
      PartOf = ["graphical-session.target"];
      After = ["graphical-session.target"];
    };

    Service = {
      Type = "simple";
      ExecStart = "${ags-widgets}/bin/ags-widgets";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };

    Install.WantedBy = ["graphical-session.target"];
  };
}
