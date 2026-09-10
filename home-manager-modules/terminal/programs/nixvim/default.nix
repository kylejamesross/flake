{config, ...}: {
  programs.nixvim = {
    enable = true;
    highlight = {
      IblIndent.fg = config.lib.stylix.colors.withHashtag.base03;
      IblScope.fg = config.lib.stylix.colors.withHashtag.base04;
    };
  };
}
