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
    configDir = ./config;
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
    ];
  };
}
