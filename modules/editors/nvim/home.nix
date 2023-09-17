#
# Neovim
#

{ pkgs, lib, ... }:

let
  fromGithub = rev: ref: repo: pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "${lib.strings.sanitizeDerivationName repo}";
    version = ref;
    src = builtins.fetchGit {
      url = "https://github.com/${repo}.git";
      ref = ref;
      rev = rev;
    };
  };
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
        vim-surround
        fidget-nvim
        nvim-colorizer-lua
        which-key-nvim
        telescope-nvim
        telescope-fzy-native-nvim
        telescope-media-files-nvim
        dracula-nvim
        gitsigns-nvim
        lualine-nvim
        nvim-scrollbar
        nvim-notify
        undotree
        nvim-lspconfig
        nvim-cmp
        cmp-nvim-lsp
        cmp-buffer
        cmp-path
        cmp_luasnip
        cmp-nvim-lua
        luasnip
        typescript-nvim
        rust-tools-nvim
        omnisharp-extended-lsp-nvim
        vim-illuminate
        neorg
        nvim-dap
        nvim-dap-ui
        nvim-dap-virtual-text  
        (fromGithub "65e47be935080f112f219b5f0bc1bf411c783f27" "master" "rstacruz/vim-xtract")
        (fromGithub "248c2001d0b24e58049eeb6884a79860923cfe13" "main" "Bryley/neoai.nvim")
      ];
      extraConfig = ''
      :luafile ~/.config/nvim/lua/user/keymaps.lua
      :luafile ~/.config/nvim/lua/user/options.lua
        '';
    };
  };
}
