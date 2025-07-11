{
  pkgs,
  osConfig,
  lib,
  ...
}: {
  config = lib.mkIf osConfig.hyprland.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      settings = {
        autogenerated = 0;
        workspace = osConfig.workspaces;
        exec-once = [
          ''${pkgs.swww}/bin/swww init''
          ''${pkgs.swayidle}/bin/swayidle -w timeout 1200 '${pkgs.swaylock-effects}/bin/swaylock -f' timeout 2400 'systemctl suspend' before-sleep '${pkgs.swaylock-effects}/bin/swaylock -f' &''
        ];
        monitor =
          map
          (
            m: let
              resolution = "${toString m.width}x${toString m.height}@${toString m.refreshRate}";
              position = "${toString m.x}x${toString m.y}";
              scale = "${toString m.scale}";
            in "${m.name},${
              if m.enabled
              then "${resolution},${position},${scale}"
              else "disable"
            }"
          ) (osConfig.monitors);
        input = {
          kb_layout = "us";
          follow_mouse = 1;
          touchpad = {
            natural_scroll = "yes";
          };
          sensitivity = 0;
        };
        general = {
          gaps_in = 5;
          gaps_out = 10;
          border_size = 2;
          layout = "dwindle";
          allow_tearing = false;
        };
        misc = {
          # disable_hyprland_logo = "yes";
        };
        decoration = {
          rounding = 10;
          blur = {
            enabled = true;
            size = 3;
            passes = 1;
            vibrancy = 0.1696;
          };
          shadow = {
            enabled = true;
            range = 4;
            render_power = 3;
          };
        };
        animations = {
          enabled = "yes";
          bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
          animation = [
            " windows, 1, 7, myBezier"
            " windowsOut, 1, 7, default, popin 80%"
            " border, 1, 10, default"
            " borderangle, 1, 8, default"
            " fade, 1, 7, default"
            " workspaces, 1, 6, default"
          ];
        };
        dwindle = {
          pseudotile = "yes";
          preserve_split = "yes";
        };
        master = {
          new_status = "master";
        };
        gestures = {
          workspace_swipe = "off";
        };
        device = {
          name = "epic-mouse-v1";
          sensitivity = -0.5;
        };
        windowrulev2 = [
          " opacity 0.80 0.80,class:^(kitty)$"
          " opacity 0.95 0.95,class:^(thunar)$"
        ];
        "$mainMod" = "SUPER";
        binde = [
          " CTRL, HOME, exec, ${pkgs.pamixer}/bin/pamixer -i 10"
          " CTRL, END, exec, ${pkgs.pamixer}/bin/pamixer -d 10"
          " CTRL, Next, exec, ${pkgs.playerctl}/bin/playerctl previous"
          " CTRL, Prior, exec, ${pkgs.playerctl}/bin/playerctl next"
        ];
        bindm = [
          "$mainMod, mouse:272, movewindow"
          "$mainMod, mouse:273, resizewindow"
        ];
        bind = [
          " $mainMod, Return, exec,${pkgs.kitty}/bin/kitty --title Kitty ${pkgs.tmux}/bin/tmux && tmux set-environment EDITOR $EDITOR"
          " $mainMod, C, killactive, "
          " $mainMod, B, exec, ${pkgs.firefox}/bin/firefox "
          " $mainMod, Q, exit, "
          " $mainMod, M, exec, ${pkgs.swaylock-effects}/bin/swaylock && systemctl suspend"
          " $mainMod, E, exec, ${pkgs.kitty}/bin/kitty --title Kitty ${pkgs.tmux}/bin/tmux -c ${pkgs.lf}/bin/lf"
          " $mainMod, V, togglefloating, "
          " $mainMod, F, fullscreen, # fullscreen"
          " $mainMod, P, exec, astal -t launcher"
          " $mainMod, D, pseudo, # dwindle"
          " $mainMod, T, togglesplit, # dwindle"
          " $mainMod, left, movefocus, l"
          " $mainMod, right, movefocus, r"
          " $mainMod, up, movefocus, u"
          " $mainMod, down, movefocus, d"
          " $mainMod, H, movefocus, l"
          " $mainMod, L, movefocus, r"
          " $mainMod, K, movefocus, u"
          " $mainMod, J, movefocus, d"
          " $mainMod, F1, workspace, 1"
          " $mainMod, F1, exec, ${pkgs.firefox}/bin/firefox --new-window"
          " $mainMod, F2, workspace, 2"
          " $mainMod, F2, exec, ${pkgs.kitty}/bin/kitty --title Kitty ${pkgs.tmux}/bin/tmux"
          " $mainMod, F3, workspace, 3"
          " $mainMod, F3, exec, ${pkgs.firefox}/bin/firefox --new-window"
          " $mainMod, F4, workspace, 4"
          " $mainMod, F4, exec, ${pkgs.dbeaver-bin}/bin/dbeaver"
          # " $mainMod, F5, workspace, 5"
          # " $mainMod, F5, exec, ${pkgs.jetbrains.rider}/bin/rider"
          " $mainMod, F6, workspace, 6"
          " $mainMod, F6, exec, ${pkgs.joplin-desktop}/bin/joplin-desktop"
          " $mainMod, F7, workspace, 7"
          " $mainMod, F7, exec, ${pkgs.brave}/bin/brave --app=https://mail.proton.me/u/8/inbox"
          " $mainMod, F7 SHIFT, workspace, 7"
          " $mainMod SHIFT, F7, exec, ${pkgs.brave}/bin/brave --app=https://outlook.office.com/mail/"
          " $mainMod, F8, workspace, 8"
          " $mainMod, F8, exec, ${pkgs.brave}/bin/brave --app=https://teams.microsoft.com"
          " $mainMod, F9, workspace, 9"
          " $mainMod, F9, exec, ${pkgs.brave}/bin/brave --app=https://music.youtube.com/"
          " $mainMod SHIFT, F9, exec, ${pkgs.brave}/bin/brave --app=https://app.plex.tv/desktop/#!/"
          " SUPER_SHIFT, F11, exec, systemctl reboot"
          " SUPER_SHIFT, F12, exec, systemctl poweroff"
          " $mainMod, F12, exec, swww-randomizer"
          '', Print, exec , ${pkgs.grim}/bin/grim -g "$(${pkgs.slurp}/bin/slurp)" - | wl-copy ''
          ''SHIFT, Print, exec , ${pkgs.grim}/bin/grim -g "$(${pkgs.slurp}/bin/slurp)" - | ${pkgs.swappy}/bin/swappy -f - ''
          " $mainMod, 1, workspace, 1"
          " $mainMod, 2, workspace, 2"
          " $mainMod, 3, workspace, 3"
          " $mainMod, 4, workspace, 4"
          " $mainMod, 5, workspace, 5"
          " $mainMod, 6, workspace, 6"
          " $mainMod, 7, workspace, 7"
          " $mainMod, 8, workspace, 8"
          " $mainMod, 9, workspace, 9"
          " $mainMod, 0, workspace, 10"
          " $mainMod, mouse_down, workspace, e+1"
          " $mainMod, mouse_up, workspace, e-1"
          " $mainMod SHIFT, 1, movetoworkspace, 1"
          " $mainMod SHIFT, 2, movetoworkspace, 2"
          " $mainMod SHIFT, 3, movetoworkspace, 3"
          " $mainMod SHIFT, 4, movetoworkspace, 4"
          " $mainMod SHIFT, 5, movetoworkspace, 5"
          " $mainMod SHIFT, 6, movetoworkspace, 6"
          " $mainMod SHIFT, 7, movetoworkspace, 7"
          " $mainMod SHIFT, 8, movetoworkspace, 8"
          " $mainMod SHIFT, 9, movetoworkspace, 9"
          " $mainMod SHIFT, 0, movetoworkspace, 10"
          " CTRL, Backslash, exec, ${pkgs.playerctl}/bin/playerctl play-pause"
          " , xf86audioraisevolume, exec, ${pkgs.pamixer}/bin/pamixer -i 10"
          " , xf86audiolowervolume, exec, ${pkgs.pamixer}/bin/pamixer -d 10"
          " , xf86AudioMicMute, exec, pactl set-source-mute @DEFAULT_SOURCE@ toggle"
          " , xf86audioMute, exec, ${pkgs.pamixer}/bin/pamixer --default-source -t"
          " , xf86audioPlay, exec, ${pkgs.playerctl}/bin/playerctl play-pause"
          " , xf86audioNext, exec, ${pkgs.playerctl}/bin/playerctl next"
          " , xf86audioPre, exec, ${pkgs.playerctl}/bin/playerctl previous"
        ];
      };
    };
  };
}
