{ pkgs, ... }:
{
    home = {
        packages = with pkgs; [
            waybar
        ];
    };

  xdg.configFile."waybar/config.jsonc".source = ./config.jsonc;
  xdg.configFile."waybar/style.css".source = ./style.css;
  xdg.configFile."waybar/nix-snowflake.svg".source = ./nix-snowflake.svg;
}
