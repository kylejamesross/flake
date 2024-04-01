{ pkgs, ... }:
{
    home = {
        packages = with pkgs; [
            git
        ];
    };

  xdg.configFile."git/.gitignore_global".source = ./.gitignore_global;
  xdg.configFile."git/config".source = ./config;
}
