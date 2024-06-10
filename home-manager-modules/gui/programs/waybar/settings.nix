{}:

{
    mainBar = {
        layer = "top";
        passthrough = false;
        "gtk-layer-shell" = true;
        "modules-left" = [
            "custom/logo"
                "hyprland/workspaces"
                "cava"
                "mpris"
        ];
        "modules-right" = [
            "tray"
                "custom/weather"
                "battery"
                "cpu"
                "disk"
                "memory"
                "pulseaudio"
                "pulseaudio#microphone"
                "clock#date"
                "clock#time"
        ];
        "custom/logo" = {
            format = "󱄅";
            tooltip = false;
        };
        "hyprland/workspaces" = {
            "disable-scroll" = true;
            format = "{icon}";
            "all-outputs" = true;
            "on-click" = "";
            "sort-by-number" = true;
            "show-special" = true;
            "format-icons" = {
                "1" = "";
                "2" = "";
                "3" = "";
                "4" = "";
                "5" = "󰌛";
                "6" = "";
                "7" = "󰇮";
                "8" = "";
                "9" = "";
                "10" = "";
            };
            "persistent-workspaces" = {
                "*" = [1 2 3 4 5 6 7 8 9 10];
            };
        };
        "cava" = {
            framerate = 30;
            autosens = 1;
            bars = 14;
            lower_cutoff_freq = 50;
            higher_cutoff_freq = 10000;
            method = "pipewire";
            source = "auto";
            stereo = true;
            bar_delimiter = 0;
            noise_reduction = 0.77;
            input_delay = 2;
            hide_on_silence = true;
            format-icons = ["▁" "▂" "▃" "▄" "▅" "▆" "▇" "█" ];
            actions = {
                "on-click-right" = "mode";
            };
        };
        "mpris" = {
            format = "  {dynamic} | {status_icon}";
            interval = 1;
            dynamic-len = 40;
            status-icons = {
                playing = "▶";
                paused = "⏸";
                stopped = "";
            };
            dynamic-order = ["title" "artist"];
            ignored-players = ["firefox"];
        };
        "wlr/taskbar" = {
            format = "{icon} {title:.25}";
            "icon-size" = 24;
            "all-outputs" = false;
            "tooltip-format" = "{title}";
            "on-click" = "";
            "on-click-middle" = "close";
        };
        battery = {
            states = {
                good = 95;
                warning = 30;
                critical = 20;
            };
            interval = 10;
            format = "{icon} {capacity}%";
            "format-charging" = " {capacity}%";
            "format-plugged" = " {capacity}%";
            "format-alt-click" = "click-right";
            "format-alt" = "{icon} {capacity}%";
            "format-icons" = ["󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
        };
        tray = {
            "icon-size" = 23;
            spacing = 10;
        };
        cpu = {
            interval = 10;
            format = " {usage}%";
        };
        disk = {
            interval = 60;
            format = "󰋊 {percentage_used}%";
        };
        memory = {
            interval = 30;
            format = " {used:0.1f}/{total:0.1f}GB";
        };
        pulseaudio = {
            format = "{icon} {volume}%";
            tooltip = false;
            "format-muted" = " Muted";
            "on-click" = "pamixer -t";
            "on-scroll-up" = "pamixer -i 5";
            "on-scroll-down" = "pamixer -d 5";
            "scroll-step" = 5;
            "format-icons" = {
                headphone = "";
                "hands-free" = "";
                headset = "";
                phone = "";
                portable = "";
                car = "";
                default = [
                    ""
                        ""
                        ""
                ];
            };
        };
        "pulseaudio#microphone" = {
            format = "{format_source}";
            "format-source" = " Mic";
            "format-source-muted" = " Muted";
            "on-click" = "pamixer --default-source -t";
            "scroll-step" = 5;
        };
        "clock#date" = {
            format = " {:%a, %b %e}";
            "tooltip-format" = "<tt><small>{calendar}</small></tt>";
            calendar = {
                mode = "month";
                "mode-mon-col" = 3;
                "weeks-pos" = "right";
                "on-scroll" = 1;
                "on-click-right" = "mode";
                format = {
                    months = "<b>{}</b>";
                    days = "<b>{}</b>";
                    weeks = "<b>W{}</b>";
                    weekdays = "<b>{}</b>";
                    today = "<b><u>{}</u></b>";
                };
            };
            actions = {
                "on-click-right" = "mode";
                "on-click-forward" = "tz_up";
                "on-click-backward" = "tz_down";
                "on-scroll-up" = "shift_up";
                "on-scroll-down" = "shift_down";
            };
        };
        "clock#time" = {
            format = "󰅐 {:%I:%M %p}";
        };
        "custom/weather" = {
            format = "{}°";
            tooltip = true;
            interval = 3600;
            exec = "wttrbar --hide-conditions";
            "return-type" = "json";
        };
    };
}
