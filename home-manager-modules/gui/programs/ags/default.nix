{
  inputs,
  system,
  ...
}: {
  imports = [
    inputs.ags.homeManagerModules.default
  ];

  programs.ags = {
    enable = true;
    systemd.enable = true;
    configDir = ./config;
    extraPackages = with inputs.astal.packages.${system}; [
      astal4
      io
      apps
      hyprland
      mpris
      notifd
      powerprofiles
      wireplumber
      network
      tray
      inputs.ags.packages.${system}.default
    ];
  };
}
