{ pkgs, lib, config, ... }:

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
                background  = "#${config.colorScheme.colors.base00}";
                foreground  = "#${config.colorScheme.colors.base05}";
                selection_background  = "#${config.colorScheme.colors.base05}";
                selection_foreground  = "#${config.colorScheme.colors.base00}";
                url_color  = "#${config.colorScheme.colors.base04}";
                cursor  = "#${config.colorScheme.colors.base05}";
                active_border_color  = "#${config.colorScheme.colors.base03}";
                inactive_border_color  = "#${config.colorScheme.colors.base01}";
                active_tab_background  = "#${config.colorScheme.colors.base00}";
                active_tab_foreground  = "#${config.colorScheme.colors.base05}";
                inactive_tab_background  = "#${config.colorScheme.colors.base01}";
                inactive_tab_foreground  = "#${config.colorScheme.colors.base04}";
                tab_bar_background  = "#${config.colorScheme.colors.base01}";
                color0  = "#${config.colorScheme.colors.base00}";
                color1  = "#${config.colorScheme.colors.base08}";
                color2  = "#${config.colorScheme.colors.base0B}";
                color3  = "#${config.colorScheme.colors.base0A}";
                color4  = "#${config.colorScheme.colors.base0D}";
                color5  = "#${config.colorScheme.colors.base0E}";
                color6  = "#${config.colorScheme.colors.base0C}";
                color7  = "#${config.colorScheme.colors.base05}";
                color8  = "#${config.colorScheme.colors.base03}";
                color9  = "#${config.colorScheme.colors.base08}";
                color10  = "#${config.colorScheme.colors.base0B}";
                color11  = "#${config.colorScheme.colors.base0A}";
                color12  = "#${config.colorScheme.colors.base0D}";
                color13  = "#${config.colorScheme.colors.base0E}";
                color14  = "#${config.colorScheme.colors.base0C}";
                color15  = "#${config.colorScheme.colors.base07}";
                color16  = "#${config.colorScheme.colors.base09}";
                color17  = "#${config.colorScheme.colors.base0F}";
                color18  = "#${config.colorScheme.colors.base01}";
                color19  = "#${config.colorScheme.colors.base02}";
                color20  = "#${config.colorScheme.colors.base04}";
                color21  = "#${config.colorScheme.colors.base06}";
            };
        };
    };
}
