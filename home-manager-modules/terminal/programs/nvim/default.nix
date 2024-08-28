{ pkgs, nixpkgs, config, ... }:

{
    programs.nixvim = {
        enable = true;
        viAlias = true;
        vimAlias = true;

        extraPlugins = with pkgs.vimPlugins; [
            popup-nvim
            plenary-nvim
            vim-sleuth
            comment-nvim
            impatient-nvim
            indent-blankline-nvim
            nvim-web-devicons
            nvim-autopairs
            vim-fugitive
            harpoon
            nvim-tree-lua
            vim-textobj-entire
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
            nvim-treesitter-parsers.vimdoc
            nvim-treesitter-parsers.regex
            nvim-treesitter-parsers.markdown
            nvim-treesitter-parsers.markdown_inline
            nvim-treesitter-parsers.nix
            nvim-treesitter-parsers.norg
            nvim-treesitter-parsers.astro
            nvim-ts-context-commentstring
            nvim-ts-autotag
            nui-nvim
            nvim-surround
            mini-nvim
            fidget-nvim
            nvim-colorizer-lua
            which-key-nvim
            telescope-nvim
            telescope-fzy-native-nvim
            telescope-media-files-nvim
            telescope-ui-select-nvim
            telescope-undo-nvim
            gitsigns-nvim
            nvim-scrollbar
            nvim-notify
            nvim-lspconfig
            nvim-cmp
            diffview-nvim
            cmp-nvim-lsp
            cmp-buffer
            cmp-path
            cmp_luasnip
            cmp-nvim-lua
            lspkind-nvim
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
        ];
        extraConfigVim = ''
            :luafile ~/.config/nvim/lua/user/keymaps.lua
            :luafile ~/.config/nvim/lua/user/options.lua
        '';
        extraConfigLua = import ./extra-lua-config.nix { inherit nixpkgs config; };
    };

    xdg.configFile."nvim" = {
        source = ./config;
        recursive = true;
    };
}
