#
# Neovim
#

{ pkgs, lib, config, ... }:

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
        nvim-base16
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
      extraLuaConfig = ''
      local status_ok, base16ColorScheme = pcall(require, "base16-colorscheme")
      if not status_ok then
        return
      end

      base16ColorScheme.setup({
        base00 = '#${config.colorScheme.colors.base00}', base01 = '#${config.colorScheme.colors.base01}', base02 = '#${config.colorScheme.colors.base02}', base03 = '#${config.colorScheme.colors.base03}',
        base04 = '#${config.colorScheme.colors.base04}', base05 = '#${config.colorScheme.colors.base05}', base06 = '#${config.colorScheme.colors.base06}', base07 = '#${config.colorScheme.colors.base07}',
        base08 = '#${config.colorScheme.colors.base08}', base09 = '#${config.colorScheme.colors.base09}', base0A = '#${config.colorScheme.colors.base0A}', base0B = '#${config.colorScheme.colors.base0B}',
        base0C = '#${config.colorScheme.colors.base0C}', base0D = '#${config.colorScheme.colors.base0D}', base0E = '#${config.colorScheme.colors.base0E}', base0F = '#${config.colorScheme.colors.base0F}',
      });
      '';
    };
  };
}
