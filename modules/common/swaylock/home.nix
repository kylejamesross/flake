
#
# swaylock
#

{ config, ... }:


{
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
line-color=${config.colorScheme.colors.base01}
ring-color=${config.colorScheme.colors.base02}
inside-color=${config.colorScheme.colors.base01}
key-hl-color=${config.colorScheme.colors.base0E}
separator-color=00000000
text-color=${config.colorScheme.colors.base06}
text-caps-lock-color=""
line-ver-color=${config.colorScheme.colors.base0E}
ring-ver-color=${config.colorScheme.colors.base0E}
inside-ver-color=${config.colorScheme.colors.base01}
text-ver-color=${config.colorScheme.colors.base06}
ring-wrong-color=${config.colorScheme.colors.base08}
text-wrong-color=${config.colorScheme.colors.base08}
inside-wrong-color=${config.colorScheme.colors.base01}
inside-clear-color=${config.colorScheme.colors.base01}
text-clear-color=${config.colorScheme.colors.base06}
ring-clear-color=${config.colorScheme.colors.base0D}
line-clear-color=${config.colorScheme.colors.base01}
line-wrong-color=${config.colorScheme.colors.base01}
bs-hl-color=${config.colorScheme.colors.base08}
datestr=%a, %B %e
timestr=%I:%M %p
fade-in=0.2
ignore-empty-password
  '';
}

