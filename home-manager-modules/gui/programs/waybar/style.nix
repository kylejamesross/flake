{ config }:

with config.lib.stylix.colors.withHashtag;

''
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

#workspaces button:nth-child(10).active {
    color: ${base08};
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
    margin-right: 10px;
}
#clock.date {
    background: ${base0D}; /* blue */
    margin-right: 0;
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
''
