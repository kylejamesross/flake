{pkgs, ...}: {
  programs.nixvim = {
    plugins.lint = {
      enable = true;

      lintersByFt = {
        astro = ["eslint_d"];
        css = ["eslint_d"];
        javascript = ["eslint_d"];
        javascriptreact = ["eslint_d"];
        "javascript.jsx" = ["eslint_d"];
        lua = ["luacheck"];
        markdownlint = ["markdownlint"];
        sh = ["shellcheck"];
        typescript = ["eslint_d"];
        typescriptreact = ["eslint_d"];
        "typescript.tsx" = ["eslint_d"];
        vue = ["eslint_d"];
        yaml = ["yamllint"];
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
      markdownlint-cli
      shellcheck
      yamllint
      luajitPackages.luacheck
    ];
  };
}
