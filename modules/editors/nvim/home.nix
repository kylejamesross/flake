#
# Neovim
#

{ pkgs, lib, config, unstable, ... }:

let
colorUtils = import ../../../utils/colors.nix { lib = lib; };
fromGithub = rev: ref: repo: pkgs.vimUtils.buildVimPlugin {
  pname = "${lib.strings.sanitizeDerivationName repo}";
  version = ref;
  src = builtins.fetchGit {
    url = "https://github.com/${repo}.git";
    ref = ref;
    rev = rev;
  };
};
in
with colorUtils;
with config.colorScheme.palette;
  let
    percent = -70;
    darkRed = shadeColor { color = base08; percent = percent; };
    darkYellow = shadeColor { color = base0A; percent = percent; };
    darkBlue = shadeColor { color = base0D; percent = percent; };
    darkOrange = shadeColor { color = base09; percent = percent; };
    darkGreen = shadeColor { color = base0B; percent = percent; };
    darkPurple = shadeColor { color = base0E; percent = percent; };
    darkCyan = shadeColor { color = base0C; percent = percent; };
in
{
  programs = {
    neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;

      plugins = with pkgs.vimPlugins; [
        popup-nvim
          plenary-nvim
          vim-sleuth
          comment-nvim
          impatient-nvim
          indent-blankline-nvim
          alpha-nvim
          nvim-web-devicons
          nvim-autopairs
          vim-fugitive
          harpoon
          nvim-tree-lua
          nvim-treesitter
          nvim-treesitter-textobjects
          nvim-treesitter-parsers.typescript
          nvim-treesitter-parsers.tsx
          nvim-treesitter-parsers.scss
          nvim-treesitter-parsers.rust
          nvim-treesitter-parsers.lua
          nvim-treesitter-parsers.jsonc
          nvim-treesitter-parsers.json
          nvim-treesitter-parsers.javascript
          nvim-treesitter-parsers.css
          nvim-treesitter-parsers.c_sharp
          nvim-treesitter-parsers.bash
          nvim-treesitter-parsers.vim
          nvim-treesitter-parsers.regex
          nvim-treesitter-parsers.markdown
          nvim-treesitter-parsers.nix
          nvim-treesitter-parsers.norg
          nvim-treesitter-parsers.astro
          nvim-ts-context-commentstring
          nvim-ts-autotag
          nui-nvim
          nvim-surround
          fidget-nvim
          nvim-colorizer-lua
          which-key-nvim
          telescope-nvim
          telescope-fzy-native-nvim
          telescope-media-files-nvim
          telescope-ui-select-nvim
          telescope-undo-nvim
          nvim-base16
          gitsigns-nvim
          lualine-nvim
          nvim-scrollbar
          nvim-notify
          nvim-lspconfig
          nvim-cmp
          cmp-nvim-lsp
          cmp-buffer
          cmp-path
          cmp_luasnip
          cmp-nvim-lua
          luasnip
          rust-tools-nvim
          omnisharp-extended-lsp-nvim
          vim-illuminate
          nvim-dap
          nvim-dap-ui
          nvim-dap-virtual-text  
          ChatGPT-nvim
          neodev-nvim
          typescript-nvim
          noice-nvim
          ];
      extraConfig = ''
        :luafile ~/.config/nvim/lua/user/keymaps.lua
        :luafile ~/.config/nvim/lua/user/options.lua

        '';
      extraLuaConfig = ''
        local status_ok, base16ColorScheme = pcall(require, "base16-colorscheme")
        if not status_ok then
          return
            end

        base16ColorScheme.setup({
            base00 = '#${base00}', base01 = '#${base01}', base02 = '#${base02}', base03 = '#${base03}',
            base04 = '#${base04}', base05 = '#${base05}', base06 = '#${base06}', base07 = '#${base07}',
            base08 = '#${base08}', base09 = '#${base09}', base0A = '#${base0A}', base0B = '#${base0B}',
            base0C = '#${base0C}', base0D = '#${base0D}', base0E = '#${base0E}', base0F = '#${base0F}',
            });

        local status_ok, indentBlankline = pcall(require, "ibl")

        if not status_ok then
          return
        end

        local highlight = {
            "RainbowRed",
            "RainbowYellow",
            "RainbowBlue",
            "RainbowOrange",
            "RainbowGreen",
            "RainbowViolet",
            "RainbowCyan",
        }

        local hooks = require "ibl.hooks"

        hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
            vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#${darkRed}"})
            vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#${darkYellow}" })
            vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#${darkBlue}" })
            vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#${darkOrange}" })
            vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#${darkGreen}" })
            vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#${darkPurple}" })
            vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#${darkCyan}" })
        end)

        indentBlankline.setup { indent = { highlight = highlight } }
            '';
    };
  };
}
