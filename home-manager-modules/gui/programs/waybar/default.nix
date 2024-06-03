{ config, ... }:

with config.lib.stylix.colors.withHashtag;

{
    programs.cava.enable = true;
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
                        "8" = "󰊻";
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
                    format = " {dynamic} | {status_icon}";
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
        };
        style = ''
* {
	border: none;
	border-radius: 10px;
	font-family: "JetbrainsMono Nerd Font";
	font-size: 15px;
	min-height: 10px;
}

window#waybar {
	background: transparent;
}

window#waybar.hidden {
	opacity: 0.2;
}

#workspaces, #cava, #mpris, #tray, #custom-weather {
	background-color: ${base00}; /* base */
}

#workspaces button.empty {
    color: alpha(${base05}, 0.5);
}

#workspaces button:hover {
    color: ${base07};
    background: transparent;
}

#workspaces button.focused {
    color: ${base07};
}

#workspaces button:nth-child(1).active {
    color: ${base09};
}

#workspaces button:nth-child(2).active {
    color: ${base0B};
}

#workspaces button:nth-child(3).active {
    color: ${base0A};
}

#workspaces button:nth-child(4).active {
    color: ${base09};
}

#workspaces button:nth-child(5).active {
    color: ${base0D};
}

#workspaces button:nth-child(6).active {
    color: ${base0F};
}
#workspaces button:nth-child(7).active {
    color: ${base0C};
}
#workspaces button:nth-child(8).active {
    color: ${base0E};
}

#workspaces button:nth-child(9).active {
    color: ${base0F};
}

#workspaces button.urgent {
    color: ${base08};
}

#window,
#workspaces,
#battery.charging,
#battery.plugged,
#battery.critical:not(.charging),
#pulseaudio,
#battery,
#clock,
#memory,
#disk,
#cpu,
#tray,
#custom-weather,
#cava,
#mpris,
#custom-logo {
	margin-top: 6px;
	margin-left: 8px;
	padding-left: 10px;
	padding-right: 10px;
	margin-bottom: 0px;
	border-radius: 10px;
	transition: none;
}

#window {
	color: transparent;
	background: transparent;
}

#battery.charging,
#battery.plugged,
#battery.critical:not(.charging),
#network,
#pulseaudio,
#battery,
#backlight,
#clock,
#memory,
#disk,
#cpu,
#custom-logo {
	color: ${base00}; /* base */
}

#custom-logo {
    padding-right: 15px;
	font-size: 20px;
}

#custom-weather, #tray {
	color: ${base05}; /* text */
}

#custom-logo {
    background: ${base0F}; /* pink */
}

#cpu {
    background: ${base08}; /* red */
}

#disk {
	background: ${base09}; /* orange */
}

#memory {
	background: ${base0A}; /* yellow */;
}

#pulseaudio {
	background: ${base0B}; /* green */;
}

#pulseaudio.microphone {
	background: ${base0C}; /* teal */;
}

#clock {
    background: ${base0E}; /* purple */
}
#clock.date {
    background: ${base0D}; /* blue */
}

#battery, #battery.charging, #battery.plugged {
	background: ${base0B}; /* green */
}

@keyframes blink {
	to {
	    background-color: ${base00}; /* base */
		color: ${base08}; /* red */
	}
}

#battery.critical:not(.charging) {
	background-color: ${base08}; /* red */
	color: ${base00}; /* base */
	animation-name: blink;
	animation-duration: 0.5s;
	animation-timing-function: linear;
	animation-iteration-count: infinite;
	animation-direction: alternate;
}
'';
    };
}
