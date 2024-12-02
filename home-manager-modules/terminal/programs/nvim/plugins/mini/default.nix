{...}: {
  programs.nixvim = {
    plugins = {
      mini = {
        enable = true;
        modules = {
          ai = {
            n_lines = 500;
          };
          surround = {};
          files = {};
        };
      };
    };
    keymaps = [
      {
        mode = "n";
        key = "<leader>e";
        action = "<CMD>lua if not MiniFiles.close() then MiniFiles.open(vim.api.nvim_buf_get_name(0)) end<CR>";
        options = {
          desc = "Open File [E]xplorer";
        };
      }
    ];
  };
}
