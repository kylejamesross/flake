{
  programs.nixvim = {
    plugins = {
      luasnip = {
        enable = true;
        fromVscode = [{paths = ./snippets;}];
      };

      cmp-nvim-lsp = {
        enable = true;
      };

      cmp-path = {
        enable = true;
      };

      cmp = {
        enable = true;

        settings = {
          snippet = {
            expand = ''
              function(args)
              require('luasnip').lsp_expand(args.body)
              end
            '';
          };

          completion = {
            completeopt = "menu,menuone,noinsert";
          };

          mapping = {
            "<C-n>" = "cmp.mapping.select_next_item()";
            "<C-p>" = "cmp.mapping.select_prev_item()";
            "<C-b>" = "cmp.mapping.scroll_docs(-4)";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
            "<C-y>" = "cmp.mapping.confirm { select = true }";
            "<C-Space>" = "cmp.mapping.complete {}";
            "<C-l>" = ''
              cmp.mapping(function()
                      if require('luasnip').expand_or_locally_jumpable() then
                      require('luasnip').expand_or_jump()
                      end
                      end, { 'i', 's' })
            '';
            "<C-h>" = ''
              cmp.mapping(function()
                      if require('luasnip').locally_jumpable(-1) then
                      require('luasnip').jump(-1)
                      end
                      end, { 'i', 's' })
            '';
          };
          sources = [
            {
              name = "luasnip";
            }
            {
              name = "nvim_lsp";
            }
            {
              name = "path";
            }
          ];
        };
      };
    };
    extraLuaPackages = ps: [
      ps.jsregexp
    ];
  };
}
