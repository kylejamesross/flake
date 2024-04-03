{ ... }: 

{
    config.monitors = [
        {
            name = "DP-1";
            width = 2560;
            height = 1440;
            refreshRate = 60;
            x = 1920;
            y = 0;
            scale = 1;
        }
        {
            name = "DP-2";
            width = 1920;
            height = 1080;
            refreshRate = 75;
            x = 4480;
            y = 0;
            scale = 1;
        }
        {
            name = "HDMI-A-1";
            width = 1920;
            height = 1080;
            refreshRate = 75;
            x = 0;
            y = 0;
            scale = 1;
        }
    ];
}
