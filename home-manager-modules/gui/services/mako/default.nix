{ config, ... }:

with config.colorScheme.palette;

{ 
    services.mako = {
        enable = true;
        layer = "overlay";
        width = 800;
        height = 200;
        borderRadius = 10;
        borderSize = 2;
        font = "JetBrainsMono 14";
        defaultTimeout = 5000;
        icons = true;
        backgroundColor = "#${base00}";
        textColor = "#${base05}";
        borderColor = "#${base0D}";
        maxIconSize = 64;
        ignoreTimeout = false;
    };
}
