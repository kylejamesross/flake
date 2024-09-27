{
  programs.nixvim = {
    plugins.none-ls = {
      enable = true;
      extraOptions = {
        enableLspFormat = true;
        updateInInsert = true;
        onAttach = ''
              function(client, bufnr)
              if client.supports_method "textDocument/formatting" then
                  vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
          vim.api.nvim_create_autocmd("BufWritePre", {
                  group = augroup,
                  buffer = bufnr,
                  callback = function()
                  vim.lsp.buf.format { bufnr = bufnr }
                  end,
                  })
          end
              end
        '';
      };
      sources = {
        code_actions = {
          statix.enable = true;
          gitsigns.enable = true;
        };
        diagnostics = { statix.enable = true; };
        formatting = {
          prettierd.enable = true;
          stylua.enable = true;
          alejandra.enable = true;
        };
      };
    };
    # keymaps = [
    # {
    #     mode = [ "n" "v" ];
    #     key = "<leader>rf";
    #     action = "<cmd>lua vim.lsp.buf.format()<cr>";
    #     options = {
    #         silent = true;
    #         desc = "LSP: [F]ormat";
    #     };
    # }
    # ];
  };
}
