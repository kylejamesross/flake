#
# gtk
#

{ config, ... }:

let finalCss = ''
@define-color accent_color #${config.colorScheme.palette.base0A};
@define-color accent_bg_color #${config.colorScheme.palette.base0A};
@define-color accent_fg_color #${config.colorScheme.palette.base00};
@define-color destructive_color #${config.colorScheme.palette.base08};
@define-color destructive_bg_color #${config.colorScheme.palette.base08};
@define-color destructive_fg_color #${config.colorScheme.palette.base00};
@define-color success_color #${config.colorScheme.palette.base0B};
@define-color success_bg_color #${config.colorScheme.palette.base0B};
@define-color success_fg_color #${config.colorScheme.palette.base00};
@define-color warning_color #${config.colorScheme.palette.base0E};
@define-color warning_bg_color #${config.colorScheme.palette.base0E};
@define-color warning_fg_color #${config.colorScheme.palette.base00};
@define-color error_color #${config.colorScheme.palette.base08};
@define-color error_bg_color #${config.colorScheme.palette.base08};
@define-color error_fg_color #${config.colorScheme.palette.base00};
@define-color window_bg_color #${config.colorScheme.palette.base00};
@define-color window_fg_color #${config.colorScheme.palette.base05};
@define-color view_bg_color #${config.colorScheme.palette.base00};
@define-color view_fg_color #${config.colorScheme.palette.base05};
@define-color headerbar_bg_color #${config.colorScheme.palette.base01};
@define-color headerbar_fg_color #${config.colorScheme.palette.base05};
@define-color headerbar_border_color #${config.colorScheme.palette.base01};
@define-color headerbar_backdrop_color @window_bg_color;
@define-color headerbar_shade_color rgba(0, 0, 0, 0.07);
@define-color sidebar_bg_color #${config.colorScheme.palette.base01};
@define-color sidebar_backdrop_color @window_bg_color;
@define-color sidebar_fg_color #${config.colorScheme.palette.base05};
@define-color sidebar_shade_color rgba(0, 0, 0, 0.07);
@define-color panel_bg_color #${config.colorScheme.palette.base01};
@define-color panel_fg_color #${config.colorScheme.palette.base05};
@define-color card_bg_color #${config.colorScheme.palette.base01};
@define-color card_fg_color #${config.colorScheme.palette.base05};
@define-color card_shade_color rgba(0, 0, 0, 0.07);
@define-color dialog_bg_color #${config.colorScheme.palette.base01};
@define-color dialog_fg_color #${config.colorScheme.palette.base05};
@define-color popover_bg_color #${config.colorScheme.palette.base01};
@define-color popover_fg_color #${config.colorScheme.palette.base05};
@define-color shade_color rgba(0, 0, 0, 0.07);
@define-color scrollbar_outline_color #${config.colorScheme.palette.base02};
@define-color blue_1 #${config.colorScheme.palette.base0D};
@define-color blue_2 #${config.colorScheme.palette.base0D};
@define-color blue_3 #${config.colorScheme.palette.base0D};
@define-color blue_4 #${config.colorScheme.palette.base0D};
@define-color blue_5 #${config.colorScheme.palette.base0D};
@define-color green_1 #${config.colorScheme.palette.base0B};
@define-color green_2 #${config.colorScheme.palette.base0B};
@define-color green_3 #${config.colorScheme.palette.base0B};
@define-color green_4 #${config.colorScheme.palette.base0B};
@define-color green_5 #${config.colorScheme.palette.base0B};
@define-color yellow_1 #${config.colorScheme.palette.base0A};
@define-color yellow_2 #${config.colorScheme.palette.base0A};
@define-color yellow_3 #${config.colorScheme.palette.base0A};
@define-color yellow_4 #${config.colorScheme.palette.base0A};
@define-color yellow_5 #${config.colorScheme.palette.base0A};
@define-color orange_1 #${config.colorScheme.palette.base09};
@define-color orange_2 #${config.colorScheme.palette.base09};
@define-color orange_3 #${config.colorScheme.palette.base09};
@define-color orange_4 #${config.colorScheme.palette.base09};
@define-color orange_5 #${config.colorScheme.palette.base09};
@define-color red_1 #${config.colorScheme.palette.base08};
@define-color red_2 #${config.colorScheme.palette.base08};
@define-color red_3 #${config.colorScheme.palette.base08};
@define-color red_4 #${config.colorScheme.palette.base08};
@define-color red_5 #${config.colorScheme.palette.base08};
@define-color purple_1 #${config.colorScheme.palette.base0E};
@define-color purple_2 #${config.colorScheme.palette.base0E};
@define-color purple_3 #${config.colorScheme.palette.base0E};
@define-color purple_4 #${config.colorScheme.palette.base0E};
@define-color purple_5 #${config.colorScheme.palette.base0E};
@define-color brown_1 #${config.colorScheme.palette.base0F};
@define-color brown_2 #${config.colorScheme.palette.base0F};
@define-color brown_3 #${config.colorScheme.palette.base0F};
@define-color brown_4 #${config.colorScheme.palette.base0F};
@define-color brown_5 #${config.colorScheme.palette.base0F};
@define-color light_1 #${config.colorScheme.palette.base01};
@define-color light_2 #${config.colorScheme.palette.base01};
@define-color light_3 #${config.colorScheme.palette.base01};
@define-color light_4 #${config.colorScheme.palette.base01};
@define-color light_5 #${config.colorScheme.palette.base01};
@define-color dark_1 #${config.colorScheme.palette.base01};
@define-color dark_2 #${config.colorScheme.palette.base01};
@define-color dark_3 #${config.colorScheme.palette.base01};
@define-color dark_4 #${config.colorScheme.palette.base01};
@define-color dark_5 #${config.colorScheme.palette.base01};
@define-color base00 #${config.colorScheme.palette.base00};
@define-color base01 #${config.colorScheme.palette.base01};
@define-color base02 #${config.colorScheme.palette.base02};
@define-color base03 #${config.colorScheme.palette.base03};
@define-color base04 #${config.colorScheme.palette.base04};
@define-color base05 #${config.colorScheme.palette.base05};
@define-color base06 #${config.colorScheme.palette.base06};
@define-color base07 #${config.colorScheme.palette.base07};
@define-color base08 #${config.colorScheme.palette.base08};
@define-color base09 #${config.colorScheme.palette.base09};
@define-color base0A #${config.colorScheme.palette.base0A};
@define-color base0B #${config.colorScheme.palette.base0B};
@define-color base0C #${config.colorScheme.palette.base0C};
@define-color base0D #${config.colorScheme.palette.base0D};
@define-color base0E #${config.colorScheme.palette.base0E};
@define-color base0F #${config.colorScheme.palette.base0F};
'';
in
{
    xdg.configFile = {
      "gtk-3.0/gtk.css".text = finalCss;
      "gtk-4.0/gtk.css".text = finalCss;
    };
}
