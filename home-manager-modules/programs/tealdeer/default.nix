{ pkgs, ... }:
{
    home = {
        packages = with pkgs; [
            tealdeer
        ];
    };

  xdg.configFile."tealdeer/config.toml".source = ./config.toml;
}
