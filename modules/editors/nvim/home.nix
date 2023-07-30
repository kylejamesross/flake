#
# Neovim
#

{ pkgs, ... }:

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
        nvim-ts-context-commentstring
        nvim-ts-autotag
        nui-nvim
        vim-surround
        fidget-nvim
        nvim-colorizer-lua
        which-key-nvim
        telescope-nvim
        telescope-fzy-native-nvim
        telescope-media-files-nvim
        dracula-nvim
        gitsigns-nvim
        bufferline-nvim
        lualine-nvim
        nvim-scrollbar
        undotree
        lsp-zero-nvim
        nvim-lspconfig
        nvim-cmp
        cmp-nvim-lsp
        cmp-buffer
        cmp-path
        cmp_luasnip
        cmp-nvim-lua
        luasnip
        typescript-nvim
        omnisharp-extended-lsp-nvim
        vim-illuminate
      ];

      extraConfig = ''
      :luafile ~/.config/nvim/init.lua
      :luafile ~/.config/nvim/after/plugin/alpha.lua
      :luafile ~/.config/nvim/after/plugin/autopairs.lua
      :luafile ~/.config/nvim/after/plugin/bufferline.lua
      :luafile ~/.config/nvim/after/plugin/colorizer.lua
      :luafile ~/.config/nvim/after/plugin/comment.lua
      :luafile ~/.config/nvim/after/plugin/dracula.lua
      :luafile ~/.config/nvim/after/plugin/gitsigns.lua
      :luafile ~/.config/nvim/after/plugin/illuminate.lua
      :luafile ~/.config/nvim/after/plugin/impatient.lua
      :luafile ~/.config/nvim/after/plugin/indent-blankline.lua
      :luafile ~/.config/nvim/after/plugin/lsp.lua
      :luafile ~/.config/nvim/after/plugin/lualine.lua
      :luafile ~/.config/nvim/after/plugin/luasnip.lua
      :luafile ~/.config/nvim/after/plugin/nvim-tree.lua
      :luafile ~/.config/nvim/after/plugin/scrollbar.lua
      :luafile ~/.config/nvim/after/plugin/surround.lua
      :luafile ~/.config/nvim/after/plugin/telescope.lua
      :luafile ~/.config/nvim/after/plugin/treesitter.lua
      :luafile ~/.config/nvim/after/plugin/typescript.lua
      :luafile ~/.config/nvim/after/plugin/which-key.lua
        '';
    };
  };
}
