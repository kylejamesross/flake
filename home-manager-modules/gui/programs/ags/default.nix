{
  pkgs,
  lib,
  osConfig,
  ...
}: {
  config = lib.mkIf osConfig.ags.enable {
    programs.ags = {
      enable = true;

      configDir = ./config;

      extraPackages = with pkgs; [
        gtksourceview
        webkitgtk
        accountsservice
        gnome-bluetooth
      ];
    };
  };
}
