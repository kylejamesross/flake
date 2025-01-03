{
  pkgs,
  config,
  ...
}:
with config.lib.stylix.colors; {
  home.packages = with pkgs; [
    tealdeer
  ];

  xdg.configFile."tealdeer/config.toml".text =
    /*
    toml
    */
    ''
      [display]
      compact = false
      use_pager = false

      [style.command_name]
      foreground = { rgb = { r = ${base08-rgb-r}, g = ${base08-rgb-g}, b = ${base08-rgb-b} } }

      [style.example_text]
      foreground = { rgb = { r = ${base0B-rgb-r}, g = ${base0B-rgb-g}, b = ${base0B-rgb-b} } }

      [style.example_code]
      foreground = { rgb = { r = ${base0D-rgb-r}, g = ${base0D-rgb-g}, b = ${base0D-rgb-b} } }

      [style.example_variable]
      foreground = { rgb = { r = ${base0D-rgb-r}, g = ${base0D-rgb-g}, b = ${base0D-rgb-b} } }
      underline = true

      [updates]
      auto_update = true
    '';
}
