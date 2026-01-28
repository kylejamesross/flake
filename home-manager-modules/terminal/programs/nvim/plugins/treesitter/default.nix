{pkgs, ...}: {
  programs.nixvim = {
    plugins = {
      treesitter = {
        enable = true;
        settings = {
          highlight = {
            enable = true;
            additional_vim_regex_highlighting = true;
          };
          incremental_selection = {
            enable = true;
            keymaps = {
              init_selection = "<C-M-k>";
              node_incremental = "<C-M-k>";
              scope_incremental = "<C-M-l>";
              node_decremental = "<C-M-j>";
            };
          };
          indent = {
            enable = true;
            disable = ["yaml"];
          };
        };
        grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
          astro
          bash
          c_sharp
          css
          fish
          html
          javascript
          json
          lua
          markdown
          markdown_inline
          nix
          regex
          rust
          scss
          styled
          toml
          typescript
          tsx
          vim
          vimdoc
          vue
          yaml
        ];
      };
      treesitter-textobjects = {
        enable = true;
        settings = {
          select = {
            enable = true;
            lookahead = true;
            keymaps = {
              "af" = "@function.outer";
              "if" = "@function.inner";
              "ac" = "@conditional.outer";
              "ic" = "@conditional.inner";
              "ib" = "@block.inner";
              "ab" = "@block.outer";
              "ip" = "@parameter.inner";
              "ap" = "@parameter.outer";
              "io" = "@object.outer";
              "oo" = "@object.inner";
            };
          };
        };
      };
      ts-context-commentstring.enable = true;
      ts-autotag.enable = true;
    };
  };
}
