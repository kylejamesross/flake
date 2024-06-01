{ ... }:

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
                clipboard_control = "write-primary write-clipboard no-append";
            };
        };
    };
}
