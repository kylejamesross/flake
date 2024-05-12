{ pkgs, config, inputs, lib, ... }:

with config.colorScheme.palette;
with inputs.nix-colors.lib-core.conversions;
with lib;

let 
    base08RGB = hexToRGB base08;
    base0BRGB = hexToRGB base0B;
    base0DRGB = hexToRGB base0D;
in
{
    home = {
        packages = with pkgs; [
            tealdeer
        ];
    };

  xdg.configFile."tealdeer/config.toml".text = ''
    [display]
    compact = false
    use_pager = false

    [style.command_name]
    foreground = { rgb = { r = ${toString ( elemAt base08RGB 0 )}, g = ${toString ( elemAt base08RGB 1 )}, b = ${toString ( elemAt base08RGB 2 ) } } }

    [style.example_text]
    foreground = { rgb = { r = ${toString ( elemAt base0BRGB 0 )}, g = ${toString ( elemAt base0BRGB 1 )}, b = ${toString ( elemAt base0BRGB 2 ) } } }

    [style.example_code]
    foreground = { rgb = { r = ${toString ( elemAt base0DRGB 0 )}, g = ${toString ( elemAt base0DRGB 1 )}, b = ${toString ( elemAt base0DRGB 2 ) } } }

    [style.example_variable]
    foreground = { rgb = { r = ${toString ( elemAt base0DRGB 0 )}, g = ${toString ( elemAt base0DRGB 1 )}, b = ${toString ( elemAt base0DRGB 2 ) } } }
    underline = true

    [updates]
    auto_update = true
  '';
}
