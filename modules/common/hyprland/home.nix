#
#
#  Hyprland Home-manager configuration
#

{ config, lib, pkgs, host, ... }:


let
  isDesktop = host.hostName == "desktop";

  monitorConf = if isDesktop then ''
monitor=DP-1, 2560x1440, 1920x0, 1
monitor=DP-2, 1920x1080, 4480x0, 1
monitor=HDMI-A-1, 1920x1080, 0x0, 1
  '' else ''
monitor=eDP-2, 1920x1080, 0x0, 0.95
  '';

  workspaceBindings = if isDesktop then ''
# workspace=DP-1,1
# workspace=DP-1,2
# workspace=DP-1,3
# workspace=DP-1,4
# workspace=DP-1,5
# workspace=DP-1,6
# workspace=HDMI-A-1,7
# workspace=HDMI-A-1,8
# workspace=DP-2,9
wsbind=1,DP-1
wsbind=2,DP-1
wsbind=3,DP-1
wsbind=4,DP-1
wsbind=5,DP-1
wsbind=6,DP-1
wsbind=7,HDMI-A-1
wsbind=8,HDMI-A-1
wsbind=9,DP-2
'' else ''
wsbind=1,eDP-2
wsbind=2,eDP-2
wsbind=3,eDP-2
wsbind=4,eDP-2
wsbind=5,eDP-2
wsbind=6,eDP-2
wsbind=7,eDP-2
wsbind=8,eDP-2
wsbind=9,eDP-2
  '';

  hyprlandConf = ''
autogenerated = 0 # remove this line to remove the warning

# See https://wiki.hyprland.org/Configuring/Monitors/
${monitorConf}
monitor=,preferred,auto,auto

# See https://wiki.hyprland.org/Configuring/Keywords/ for more

# Execute your favorite apps at launch
exec-once = ${pkgs.swww}/bin/swww init
exec-once = ${pkgs.waybar}/bin/waybar 
exec-once = ${pkgs.mako}/bin/mako 
exec-once = ${pkgs.networkmanagerapplet}/bin/nm-applet
exec-once = ${pkgs.wl-clipboard}/bin/wl-paste --watch cliphist store

# For all categories, see https://wiki.hyprland.org/Configuring/Variables/
input {
    kb_layout = us
    kb_variant =
    kb_model =
    kb_options = 
    kb_rules =

    follow_mouse = 1


    touchpad {
        natural_scroll = yes
    }

    sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
}

general {
    # See https://wiki.hyprland.org/Configuring/Variables/ for more

    gaps_in = 5
    gaps_out = 10

    border_size = 2.5
    col.active_border = rgba(9b87ffff) rgba(ff8ec3ff) 45deg
    col.inactive_border = rgba(595959ff)

    layout = dwindle
}

misc {
    disable_hyprland_logo = yes
}

decoration {
    # See https://wiki.hyprland.org/Configuring/Variables/ for more

    rounding = 10

    blur = yes
    blur_size = 3
    blur_passes = 1
    blur_new_optimizations = on
    # blur {
    #     enabled = true
    #     size = 3
    #     passes = 1
    # }

    drop_shadow = true
    shadow_range = 4
    shadow_render_power = 3
    col.shadow = rgba(1a1a1aee)
}

animations {
    enabled = yes

    # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

    bezier = myBezier, 0.05, 0.9, 0.1, 1.05

    animation = windows, 1, 7, myBezier
    animation = windowsOut, 1, 7, default, popin 80%
    animation = border, 1, 10, default
    animation = borderangle, 1, 8, default
    animation = fade, 1, 7, default
    animation = workspaces, 1, 6, default
}

dwindle {
    # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
    pseudotile = yes # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
    preserve_split = yes # you probably want this
}

master {
    # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
    new_is_master = true
}

gestures {
    # See https://wiki.hyprland.org/Configuring/Variables/ for more
    workspace_swipe = off
}

# Example per-device config
# See https://wiki.hyprland.org/Configuring/Keywords/#executing for more
device:epic-mouse-v1 {
    sensitivity = -0.5
}


# Example windowrule v1
# windowrule = float, ^(kitty)$
# Example windowrule v2
# windowrulev2 = float,class:^(kitty)$,title:^(kitty)$
# See https://wiki.hyprland.org/Configuring/Window-Rules/ for more
windowrulev2 = opacity 0.80 0.80,class:^(kitty)$
windowrulev2 = opacity 0.95 0.95,class:^(thunar)$

# See https://wiki.hyprland.org/Configuring/Keywords/ for more
$mainMod = SUPER

# Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
bind = $mainMod, Return, exec,kitty --title Kitty tmux
bind = $mainMod, C, killactive, 
bind = $mainMod, B, exec, brave 
bind = $mainMod, Q, exit, 
bind = $mainMod, M, exec, swaylock && systemctl suspend
bind = $mainMod, E, exec, thunar
bind = $mainMod, V, togglefloating, 
bind = $mainMod, F, fullscreen, # fullscreen
bind = $mainMod, P, exec, wofi --allow-images --show drun
bind = $mainMod, D, pseudo, # dwindle
bind = $mainMod, T, togglesplit, # dwindle
bind = ALT, V, exec, cliphist list | wofi -dmenu | cliphist decode | wl-copy

# Clipboard binds
bind = SHIFT, Print, exec , grim -g "$(slurp)" - | swappy -f -
bind = , Print, exec , grim -g "$(slurp)" - | wl-copy

# System keys
bind = SUPER_SHIFT, F12, exec, shutdown now
bind = SUPER_SHIFT, F11, exec, reboot
bind = $mainMod, F12, exec, ~/flake/bin/swww_randomizer

# Move focus with mainMod + arrow keys
bind = $mainMod, left, movefocus, l
bind = $mainMod, right, movefocus, r
bind = $mainMod, up, movefocus, u
bind = $mainMod, down, movefocus, d
bind = $mainMod, H, movefocus, l
bind = $mainMod, L, movefocus, r
bind = $mainMod, K, movefocus, u
bind = $mainMod, J, movefocus, d

# Launching apps
bind = $mainMod, F1, workspace, 1
bind = $mainMod, F1, exec, brave --new-window
bind = $mainMod, F2, workspace, 2
bind = $mainMod, F2, exec, kitty --title Kitty tmux
bind = $mainMod, F3, workspace, 3
bind = $mainMod, F3, exec, brave --new-window
bind = $mainMod, F4, workspace, 4
bind = $mainMod, F4, exec, dbeaver
bind = $mainMod, F5, workspace, 5
bind = $mainMod, F5, exec, rider
bind = $mainMod, F7, workspace, 7
bind = $mainMod, F7, exec, thunderbird
bind = $mainMod, F8, workspace, 8
bind = $mainMod, F8, exec, brave --new-window https://teams.microsoft.com/
bind = $mainMod, F9, workspace, 9
bind = $mainMod, F9, exec, brave --new-window https://music.youtube.com/

${workspaceBindings}

# Switch workspaces with mainMod + [0-9]
bind = $mainMod, 1, workspace, 1
bind = $mainMod, 2, workspace, 2
bind = $mainMod, 3, workspace, 3
bind = $mainMod, 4, workspace, 4
bind = $mainMod, 5, workspace, 5
bind = $mainMod, 6, workspace, 6
bind = $mainMod, 7, workspace, 7
bind = $mainMod, 8, workspace, 8
bind = $mainMod, 9, workspace, 9
bind = $mainMod, 0, workspace, 10

# Move active window to a workspace with mainMod + SHIFT + [0-9]
bind = $mainMod SHIFT, 1, movetoworkspace, 1
bind = $mainMod SHIFT, 2, movetoworkspace, 2
bind = $mainMod SHIFT, 3, movetoworkspace, 3
bind = $mainMod SHIFT, 4, movetoworkspace, 4
bind = $mainMod SHIFT, 5, movetoworkspace, 5
bind = $mainMod SHIFT, 6, movetoworkspace, 6
bind = $mainMod SHIFT, 7, movetoworkspace, 7
bind = $mainMod SHIFT, 8, movetoworkspace, 8
bind = $mainMod SHIFT, 9, movetoworkspace, 9
bind = $mainMod SHIFT, 0, movetoworkspace, 10

# Scroll through existing workspaces with mainMod + scroll
bind = $mainMod, mouse_down, workspace, e+1
bind = $mainMod, mouse_up, workspace, e-1

# Move/resize windows with mainMod + LMB/RMB and dragging
bindm = $mainMod, mouse:272, movewindow
bindm = $mainMod, mouse:273, resizewindow

# Media key bindings
binde = CTRL, HOME, exec, pamixer -i 10
binde = CTRL, END, exec, pamixer -d 10
binde = CTRL, Next, exec, playerctl previous
binde = CTRL, Prior, exec, playerctl next
bind = CTRL, Backslash, exec, playerctl play-pause

bind = , xf86audioraisevolume, exec, pamixer -i 10
bind = , xf86audiolowervolume, exec, pamixer -d 10
bind = , xf86AudioMicMute, exec, pactl set-source-mute @DEFAULT_SOURCE@ toggle
bind = , xf86audioMute, exec, pamixer --default-source -t
bind = , xf86audioPlay, exec, playerctl play-pause
bind = , xf86audioNext, exec, playerctl next
bind = , xf86audioPre, exec, playerctl previous
  '';
in
{
  xdg.configFile."hypr/hyprland.conf".text = hyprlandConf;
}