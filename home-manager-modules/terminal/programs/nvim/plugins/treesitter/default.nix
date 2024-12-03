{pkgs, ...}: {
  programs.nixvim = {
    plugins = {
      treesitter-textobjects.enable = true;
      ts-context-commentstring.enable = true;
      ts-autotag.enable = true;

      treesitter = {
        enable = true;
        settings.highlight.enable = true;

        grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
          typescript
          tsx
          scss
          rust
          lua
          json
          javascript
          css
          c_sharp
          bash
          vim
          vimdoc
          regex
          markdown
          markdown_inline
          nix
          astro
          html
          vue
        ];
      };
    };

    extraConfigLua = ''
      local status_ok, configs = pcall(require, "nvim-treesitter.configs")
      if not status_ok then
        return
      end

      configs.setup({
        sync_install = false,
        auto_install = false,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = { enable = true, disable = { "yaml" } },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<C-M-k>",
            node_incremental = "<C-M-k>",
            scope_incremental = "<C-M-l>",
            node_decremental = "<C-M-j>",
          },
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@conditional.outer",
              ["ic"] = "@conditional.inner",
              ["ib"] = "@block.inner",
              ["ab"] = "@block.outer",
              ["ip"] = "@parameter.inner",
              ["ap"] = "@parameter.outer",
              ["io"] = "@object.outer",
              ["oo"] = "@object.inner",
            },
          },
        },
      })
    '';
  };
}
