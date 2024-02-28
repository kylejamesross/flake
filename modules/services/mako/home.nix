{ pkgs, config, ... }:

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
        backgroundColor = "#${config.colorScheme.palette.base00}";
        textColor = "#${config.colorScheme.palette.base05}";
        borderColor = "#${config.colorScheme.palette.base0D}";
        maxIconSize = 64;
        ignoreTimeout = false;
    };
}
