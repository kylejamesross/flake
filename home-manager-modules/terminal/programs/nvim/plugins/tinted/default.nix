let
  theme = "catppuccin-mocha";
in
  {pkgs, ...}: {
    programs.nixvim = {
      extraPlugins = [pkgs.vimPlugins.tinted-nvim];
      extraConfigLua =
        #lua
        ''
          require("tinted-nvim").setup({
            default_scheme = "base24-${theme}",
            highlights = {
              overrides = function(palette)
                return {
                  CursorLine = {
                    bg = { lighten = palette.base00, amount = 0.05 },
                  },
                  Visual = {
                    bg = { lighten = palette.base00, amount = 0.05 },
                  },
                }
              end,
            },
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
