{ pkgs, ... }:

{
    programs.swaylock = {
        enable = true;
        package = pkgs.swaylock-effects;
        settings = {
            daemonize = true;
            show-failed-attempts = true;
            clock = true;
            screenshot = true;
            effect-blur = "9x5";
            effect-vignette = "0.5:0.5";
            indicator = true;
            indicator-radius = 200;
            indicator-thickness = 20;
            datestr = "%a, %B %e";
            timestr = "%I:%M %p";
            fade-in = 0.2;
            ignore-empty-password = true;
        };
    };
}
