

#
# btop base16 theme
#

{ config, ... }:


{
  xdg.configFile."btop/themes/base16.theme".text = ''
theme[main_bg]="#${config.colorScheme.colors.base00}"
theme[main_fg]="#${config.colorScheme.colors.base06}"
theme[title]="#${config.colorScheme.colors.base06}"
theme[hi_fg]="#${config.colorScheme.colors.base08}"
theme[selected_bg]="#${config.colorScheme.colors.base03}"
theme[selected_fg]="#${config.colorScheme.colors.base0E}"
theme[inactive_fg]="#${config.colorScheme.colors.base01}"  
theme[graph_text]="#${config.colorScheme.colors.base04}"
theme[proc_misc]="#${config.colorScheme.colors.base0B}"
theme[cpu_box]="#${config.colorScheme.colors.base04}"
theme[mem_box]="#${config.colorScheme.colors.base04}"
theme[net_box]="#${config.colorScheme.colors.base04}"
theme[proc_box]="#${config.colorScheme.colors.base04}"
theme[div_line]="#${config.colorScheme.colors.base04}"
theme[temp_start]="#${config.colorScheme.colors.base0B}"
theme[temp_mid]=""
theme[temp_end]="#${config.colorScheme.colors.base08}"
theme[cpu_start]="#${config.colorScheme.colors.base0C}"
theme[cpu_mid]="#${config.colorScheme.colors.base09}"
theme[cpu_end]="#${config.colorScheme.colors.base08}"
theme[free_mid]="#${config.colorScheme.colors.base09}"
theme[free_end]="#${config.colorScheme.colors.base0C}"
theme[cached_mid]="#${config.colorScheme.colors.base0D}"
theme[cached_end]="#${config.colorScheme.colors.base0C}"
theme[available_mid]="#${config.colorScheme.colors.base09}"
theme[available_end]="#${config.colorScheme.colors.base0A}"
theme[used_mid]="#${config.colorScheme.colors.base09}"
theme[used_end]="#${config.colorScheme.colors.base08}"
theme[download_mid]="#${config.colorScheme.colors.base0D}"
theme[download_end]="#${config.colorScheme.colors.base0B}"
theme[upload_start]="#${config.colorScheme.colors.base08}"
theme[upload_mid]="#${config.colorScheme.colors.base09}"
theme[upload_end]="#${config.colorScheme.colors.base0A}"
theme[process_start]="#${config.colorScheme.colors.base0C}"
theme[process_mid]="#${config.colorScheme.colors.base0F}"
theme[process_end]="#${config.colorScheme.colors.base08}"
  '';
}
