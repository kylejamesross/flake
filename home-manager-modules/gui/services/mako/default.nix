{ ... }:

{ 
    services.mako = {
        enable = true;
        layer = "overlay";
        width = 800;
        height = 200;
        borderRadius = 10;
        borderSize = 2;
        defaultTimeout = 5000;
        icons = true;
        maxIconSize = 64;
        ignoreTimeout = false;
    };
}
