{
  programs.nixvim.plugins.lsp.servers.omnisharp = {
    enable = true;
    settings = {
      formattingOptions = {
        enableEditorConfigSupport = true;
        organizeImports = true;
      };
      roslynExtensionsOptions = {
        enableAnalyzersSupport = true;
      };
    };
    onAttach.function =
      #lua
      ''
        vim.keymap.set(
          "n",
          "gd",
          "<cmd>lua require('omnisharp_extended').lsp_definition()<cr>",
          { remap = false, silent = true, desc = "LSP: [G]oto [D]efinition" }
        )
        vim.keymap.set(
          "n",
          "<leader>ld",
          "<cmd>lua require('omnisharp_extended').lsp_type_definition()<cr>",
          { remap = false, silent = true, desc = "Type [D]efinition" }
        )
        vim.keymap.set(
          "n",
          "gr",
          "<cmd>lua require('omnisharp_extended').lsp_references()<cr>",
          { remap = false, silent = true, desc = "LSP: [G]o to [R]eferences" }
        )
        vim.keymap.set(
          "n",
          "gi",
          "<cmd>lua require('omnisharp_extended').lsp_implementation()<cr>",
          { noremap = true, silent = true, desc = "LSP: [G]o to [I]mplementation" }
        )
      '';
  };
}
