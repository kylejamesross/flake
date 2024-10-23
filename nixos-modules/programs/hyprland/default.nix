{
  pkgs,
  lib,
  config,
  ...
}:
with config.lib.stylix.colors.withHashtag; {
  options.hyprland.enable = lib.mkEnableOption "Whether to enable hyprland";

  config = lib.mkIf config.hyprland.enable {
    programs.hyprland.enable = true;

    environment.etc = {
      "greetd/greeter.js".source = ./greeter.js;
      "greetd/style.css".text =
        /*
        css
        */
        ''
          .window {
              background-image: linear-gradient(to top, ${base0B} 0%, ${base0F} 100%);
          }
          .login {
              padding: 30px;
              min-width: 400px;
              background-image: linear-gradient(-225deg, ${base0B} 50%, ${base0F} 50%);
              border-radius: 10px;
          }
          .login-label {
              font-size: 1.5rem;
          }
        '';
      "greetd/hyprland.conf".text = ''
        exec-once = ${pkgs.ags}/bin/ags --config /etc/greetd/greeter.js; hyprctl dispatch exit

        monitor=,preferred,auto,auto

        env = XCURSOR_SIZE,24
        env = HYPRCURSOR_SIZE,24

        general {
            gaps_in = 5
            gaps_out = 20

            border_size = 2

            col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
            col.inactive_border = rgba(595959aa)

            resize_on_border = false

            allow_tearing = false

            layout = dwindle
        }

        decoration {
            rounding = 10

            active_opacity = 1.0
            inactive_opacity = 1.0

            drop_shadow = true
            shadow_range = 4
            shadow_render_power = 3
            col.shadow = rgba(1a1a1aee)

            blur {
                enabled = true
                size = 3
                passes = 1

                vibrancy = 0.1696
            }
        }

        animations {
            enabled = true

            bezier = myBezier, 0.05, 0.9, 0.1, 1.05

            animation = windows, 1, 7, myBezier
            animation = windowsOut, 1, 7, default, popin 80%
            animation = border, 1, 10, default
            animation = borderangle, 1, 8, default
            animation = fade, 1, 7, default
            animation = workspaces, 1, 6, default
        }

        dwindle {
            pseudotile = true
            preserve_split = true
        }

        master {
            new_status = master
        }

        misc {
            force_default_wallpaper = -1
            disable_hyprland_logo = true
        }

        input {
            kb_layout = us
            kb_variant =
            kb_model =
            kb_options =
            kb_rules =

            follow_mouse = 1

            sensitivity = 0

            touchpad {
                natural_scroll = false
            }
        }

        gestures {
            workspace_swipe = false
        }

        device {
            name = epic-mouse-v1
            sensitivity = -0.5
        }

        $mainMod = SUPER

        bind = SUPER_SHIFT, F11, exec, systemctl reboot
        bind = SUPER_SHIFT, F12, exec, systemctl poweroff

        windowrulev2 = suppressevent maximize, class:.*
      '';
    };
  };
}
