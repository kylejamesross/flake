{ pkgs, ... }:
{
    home = {
        packages = with pkgs; [
            btop
        ];
    };

    xdg.configFile."btop/btop.conf".source = ./btop.conf;
}
