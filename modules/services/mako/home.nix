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
        backgroundColor = "#${config.colorScheme.colors.base00}";
        textColor = "#${config.colorScheme.colors.base05}";
        borderColor = "#${config.colorScheme.colors.base0D}";
        maxIconSize = 64;
        ignoreTimeout = false;
    };
}
