{ pkgs, config, ... }:

with config.colorScheme.palette;

{
    home = {
        packages = with pkgs; [
            swaylock-effects
        ];
    };
    xdg.configFile."swaylock/config".text = ''
        daemonize
        show-failed-attempts
        clock
        screenshot
        effect-blur=9x5
        effect-vignette=0.5:0.5
        color=1f1d2e80
        font="JetBrainsMono"
        indicator
        indicator-radius=200
        indicator-thickness=20
        line-color=${base01}
        ring-color=${base02}
        inside-color=${base01}
        key-hl-color=${base0E}
        separator-color=00000000
        text-color=${base06}
        text-caps-lock-color=""
        line-ver-color=${base0E}
        ring-ver-color=${base0E}
        inside-ver-color=${base01}
        text-ver-color=${base06}
        ring-wrong-color=${base08}
        text-wrong-color=${base08}
        inside-wrong-color=${base01}
        inside-clear-color=${base01}
        text-clear-color=${base06}
        ring-clear-color=${base0D}
        line-clear-color=${base01}
        line-wrong-color=${base01}
        bs-hl-color=${base08}
        datestr=%a, %B %e
        timestr=%I:%M %p
        fade-in=0.2
        ignore-empty-password
    '';
}
