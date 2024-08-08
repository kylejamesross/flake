{ pkgs, ... }:

{
    stylix = {
        enable = true;
        base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
        image = ./acoolrocket-dalle2-hokusai-non-prompt-landscape.png;
        cursor = {
            package = pkgs.bibata-cursors;
            name = "Bibata-Modern-Ice";
        };
        fonts = {
            monospace = {
                package = pkgs.nerdfonts.override {fonts = ["JetBrainsMono"];};
                name = "JetBrainsMono Nerd Font Mono";
            };
            sansSerif = {
                package = pkgs.dejavu_fonts;
                name = "DejaVu Sans";
            };
            serif = {
                package = pkgs.dejavu_fonts;
                name = "DejaVu Serif";
            };
            sizes = {
                applications = 12;
                terminal = 15;
                desktop = 10;
                popups = 10;
            };
        };
        opacity = {
            applications = 1.0;
            terminal = 1.0;
            desktop = 1.0;
            popups = 1.0;
        };
    };
}
