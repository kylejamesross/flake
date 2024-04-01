{ pkgs, ... }:

{
    home = {
        packages = with pkgs; [
            gnome.file-roller
                ffmpegthumbnailer
                (xfce.thunar.override {
                 thunarPlugins = [
                 xfce.thunar-volman
                 xfce.thunar-archive-plugin
                 ];
                 })
        ];
    };
}
