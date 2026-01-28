{pkgs, ...}: {
  programs.nixvim = {
    plugins.lint = {
      enable = true;

      lintersByFt = {
        javascript = ["eslint_d"];
        javascriptreact = ["eslint_d"];
        "javascript.jsx" = ["eslint_d"];

        typescript = ["eslint_d"];
        typescriptreact = ["eslint_d"];
        "typescript.tsx" = ["eslint_d"];

        vue = ["eslint_d"];
        svelte = ["eslint_d"];
        astro = ["eslint_d"];
      };

      autoCmd = {
        group = "lint";
        event = ["BufEnter" "BufWritePost" "InsertLeave"];
        callback.__raw = ''
          function()
            if vim.opt_local.modifiable:get() then
              require("lint").try_lint()
            end
          end
        '';
      };
    };

    autoGroups = {
      lint = {
        clear = true;
      };
    };

    extraPackages = with pkgs; [
      eslint_d
    ];
  };
}
