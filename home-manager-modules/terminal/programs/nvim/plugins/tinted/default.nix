{
  pkgs,
  theme,
  ...
}: {
  programs.nixvim = {
    extraPlugins = [pkgs.vimPlugins.tinted-nvim];

    extraConfigLua = ''
      require("tinted-nvim").setup({
        default_scheme = "base24-${theme}",
      })
      vim.cmd("colorscheme base24-${theme}")
    '';

    plugins = {
      guess-indent.enable = true;
      illuminate.enable = true;
      rainbow-delimiters.enable = true;
      ts-autotag.enable = true;
      markdown-preview.enable = true;
      web-devicons.enable = true;
      otter.enable = true;
      nvim-autopairs.enable = true;
    };
  };
}
