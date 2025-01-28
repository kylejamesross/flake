{
  pkgs,
  lib,
  osConfig,
  inputs,
  ...
}: {
  config = lib.mkIf osConfig.ags.enable {
    programs.ags = {
      enable = true;

      configDir = ./config;

      extraPackages = with pkgs;
        [
          gtk3
          gtk4
          dart-sass
        ]
        ++ (with inputs.ags.packages.${pkgs.system}; [
          hyprland
          astal3
          mpris
          network
          notifd
          # powerprofiles
          apps
          tray
          wireplumber
          inputs.astal.packages.${pkgs.system}.default
        ]);
    };
  };
}
