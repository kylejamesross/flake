{ pkgs, osConfig, ... }:


{
  programs.ags = {
    enable = true;

    configDir = osConfig.agsConfigDirectory;

    extraPackages = with pkgs; [
      gtksourceview
      webkitgtk
      accountsservice
    ];
  };
}
