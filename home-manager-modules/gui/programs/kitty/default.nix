{ config, ... }:

with config.colorScheme.palette;

{
    programs = {
        kitty = {
            enable = true;
            settings = {
                font_family = "JetBrains Mono";
                bold_font = "JetBrains Mono Bold";
                italic_font = "JetBrains Mono Italic";
                bold_italic_font = "JetBrains Mono Bold Italic";
                font_size="13.5";
                open_url_with = "firefox";
                enable_audio_bell = false;
                confirm_os_window_close = 0;
                background_opacity = "0.95";
                background  = "#${base00}";
                foreground  = "#${base05}";
                selection_background  = "#${base05}";
                selection_foreground  = "#${base00}";
                url_color  = "#${base04}";
                cursor  = "#${base05}";
                active_border_color  = "#${base03}";
                inactive_border_color  = "#${base01}";
                active_tab_background  = "#${base00}";
                active_tab_foreground  = "#${base05}";
                inactive_tab_background  = "#${base01}";
                inactive_tab_foreground  = "#${base04}";
                tab_bar_background  = "#${base01}";
                color0  = "#${base00}";
                color1  = "#${base08}";
                color2  = "#${base0B}";
                color3  = "#${base0A}";
                color4  = "#${base0D}";
                color5  = "#${base0E}";
                color6  = "#${base0C}";
                color7  = "#${base05}";
                color8  = "#${base03}";
                color9  = "#${base08}";
                color10  = "#${base0B}";
                color11  = "#${base0A}";
                color12  = "#${base0D}";
                color13  = "#${base0E}";
                color14  = "#${base0C}";
                color15  = "#${base07}";
                color16  = "#${base09}";
                color17  = "#${base0F}";
                color18  = "#${base01}";
                color19  = "#${base02}";
                color20  = "#${base04}";
                color21  = "#${base06}";
                clipboard_control = "write-primary write-clipboard no-append";
            };
        };
    };
}
