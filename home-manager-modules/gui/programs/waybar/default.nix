{ config, ... }:

with config.colorScheme.palette;

{
    xdg.configFile."waybar/snowflake.svg".source = ./snowflake.svg;
    programs.waybar = {
        enable = true;
        systemd.enable = true;
        settings = {
            mainBar = {
                layer = "top";
                passthrough = false;
                "gtk-layer-shell" = true;
                "modules-left" = [
                    "custom/logo"
                        "hyprland/workspaces"
                ];
                "modules-right" = [
                    "tray"
                        "cpu"
                        "disk"
                        "memory"
                        "pulseaudio"
                        "pulseaudio#microphone"
                        "battery"
                        "custom/weather"
                        "clock#date"
                        "clock#time"
                ];
                "custom/logo" = {
                    format = "  ";
                    "on-click" = "";
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
                    "persistent_workspaces" = {
                        "*" = [1 2 3 4 5 6 7 8 9 10];
                    };
                };
                "wlr/taskbar" = {
                    format = "{icon} {title:.25}";
                    "icon-size" = 24;
                    "all-outputs" = false;
                    "tooltip-format" = "{title}";
                    "on-click" = "";
                    "on-click-middle" = "close";
                    "ignore-list" = [
                        "wofi"
                    ];
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
                    "icon-size" = 21;
                    spacing = 5;
                };
                cpu = {
                    interval = 10;
                    format = " {usage}%";
                };
                disk = {
                    interval = 60;
                    format = " {percentage_used}%";
                };
                memory = {
                    interval = 30;
                    format = " {used:0.1f}/{total:0.1f}GB";
                };
                pulseaudio = {
                    format = "{icon}  {volume}%";
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
        };
        style = ''
* {
    font-family: "JetBrainsMono Nerd Font", Roboto, Helvetica, Arial, sans-serif;
    font-size: 13px;
}

window#waybar {
    background-color: #${base01}; /* header_bg_color */
    color: #${base05};
    transition-property: background-color;
    transition-duration: .5s;
    border-radius: 0;
    border-top: 1px solid #${base04}; /* ligthened header_bg_color */
    border-bottom: 1px solid #${base04}; /* ligthened header_bg_color */
}

.modules-left, .modules-center, .modules-right {
    margin: 7px;
}

button {
    box-shadow: inset 0 -3px transparent;
    border: none;
    border-radius: 0;
}

button:hover {
    background: inherit;
}

#workspaces, .modules-right {
    border-radius: 10px;
    background-color: #${base02};
    border: 1px solid #${base04};
}

#workspaces button {
    padding: 0 10px;
    color: #${base05};
}

#workspaces button.empty {
    color: alpha(#${base05}, 0.5);
}

#workspaces button:hover {
    color: #${base07};
}

#workspaces button.focused {
    color: #${base07};
}

#workspaces button:nth-child(1).active {
    color: #${base09};
}

#workspaces button:nth-child(2).active {
    color: #${base0B};
}

#workspaces button:nth-child(3).active {
    color: #${base0A};
}

#workspaces button:nth-child(4).active {
    color: #${base09};
}

#workspaces button:nth-child(5).active {
    color: #${base0D};
}

#workspaces button:nth-child(6).active {
    color: #${base0F};
}
#workspaces button:nth-child(7).active {
    color: #${base0C};
}
#workspaces button:nth-child(8).active {
    color: #${base0E};
}
#workspaces button:nth-child(9).active {
    color: #${base0F};
}

#workspaces button.urgent {
    color: #${base08};
}


#custom-logo {
    font-size: 1.5rem;
    background: url('/home/kyle/.config/waybar/snowflake.svg');
    background-size: 24px 24px;
    background-repeat: no-repeat;
    background-position: center;
    margin: 0 6px;
}

#clock,
#battery,
#cpu,
#memory,
#disk,
#temperature,
#backlight,
#network,
#pulseaudio,
#wireplumber,
#custom-media,
#tray,
#mode,
#idle_inhibitor,
#scratchpad,
#mpd {
    padding: 0 10px;
    color: #ffffff;
}

#window,
#workspaces {
    margin: 0 4px;
}

/* If workspaces is the leftmost module, omit left margin */
.modules-left > widget:first-child > #workspaces {
    margin-left: 0;
}

/* If workspaces is the rightmost module, omit right margin */
.modules-right > widget:last-child > #workspaces {
    margin-right: 0;
}

#battery, #battery.charging, #battery.plugged, #cpu {
    color: #${base0B};
}

#clock.date, #battery.warning:not(.charging), #disk {
    color: #${base0A};
}

#clock, #battery.critical:not(.charging), #network.disconnected {
    color: #${base08};
}

#memory {
    color: #${base09};
}

#pulseaudio {
    color: #${base0E};
}

#pulseaudio.muted {
    color: alpha(#${base0E}, 0.6);
}

#pulseaudio.microphone, #network {
    color: #${base0D};
}

#custom-weather {
    color: #${base05};
}

label:focus {
    color: #000000;
}

@keyframes blink {
    to {
    color: #ffffff;
    }
}

#battery.critical:not(.charging) {
    color: #${base08};
    animation-name: blink;
    animation-duration: 0.5s;
    animation-timing-function: linear;
    animation-iteration-count: infinite;
    animation-direction: alternate;
}
        '';
    };
}
